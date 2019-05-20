'use strict'
const axios = require('axios');
const crypto = require('crypto');
const OAuth = require('oauth-1.0a');
const Twitter = require('twitter');
const queryString = require('query-string');

const nodecgApiContext = require("./util/nodecg-api-context");
const nodecg = nodecgApiContext.get();

// Replicant
const twitterAccess = nodecg.Replicant('twitter-token');

const consumerKey = nodecg.bundleConfig.twitter.consumer_key;
const consumerSecret = nodecg.bundleConfig.twitter.consumer_secret;

const callbackUrl = `http://${nodecg.config.baseURL}/bundles/${nodecg.bundleName}/dashboard/twitter-callback.html`;

/**
 * Twitter request token stored in memory
 */
let requestToken = {
	token: '',
	secret: '',
};

/**
 * Twitter client stored in memory
 */
let client = null;
// AccessToken取得済みだったらTwitterClient生成
nodecg.readReplicant('twitter-token', token => {
    if (token.access_token && token.access_secret) {
        client = new Twitter({
            consumer_key: consumerKey,
            consumer_secret: consumerSecret,
            access_token_key: token.access_token,
            access_token_secret: token.access_secret
        });
        nodecg.log.info('Init Twitter Client');
    }
});

const oauth = new OAuth({
    consumer: {
        key: consumerKey,
        secret: consumerSecret,
    },
    signature_method: 'HMAC-SHA1',
    hash_function: (baseString, key) => {
        return crypto
            .createHmac('sha1', key)
            .update(baseString)
            .digest('base64');
    },
    realm: '',
});

const getRequestToken = async () => {
    const REQUEST_TOKEN_URL = 'https://api.twitter.com/oauth/request_token';
    const oauthData = oauth.authorize({
        url: REQUEST_TOKEN_URL,
        method: 'POST',
        data: {
            oauth_callback: callbackUrl,
        },
    });
    const res = await axios.post(REQUEST_TOKEN_URL, undefined, {
        headers: oauth.toHeader(oauthData),
    });
    const requestTokenParams = queryString.parse(res.data);
    return {
        token: requestTokenParams['oauth_token'] || '',
        secret: requestTokenParams['oauth_token_secret'] || '',
    };
};

const getAccessToken = async oauthVerifier => {
    const ACCESS_TOKEN_URL = 'https://api.twitter.com/oauth/access_token';
    const data = {oauth_verifier: oauthVerifier};
    const oauthData = oauth.authorize(
        {
            url: ACCESS_TOKEN_URL,
            method: 'POST',
            data,
        },
        {key: requestToken.token, secret: requestToken.token},
    );
    const res = await axios.post(ACCESS_TOKEN_URL, data, {
        headers: oauth.toHeader(oauthData),
    });
    const accessTokenParams = queryString.parse(res.data);
    return {
        name: accessTokenParams['screen_name'] || '',
        token: accessTokenParams['oauth_token'] || '',
        secret: accessTokenParams['oauth_token_secret'] || '',
    };
};

nodecg.listenFor('twitter:startLogin', async (_, cb) => {
    if (!cb || cb.handled) {
        return;
    }

    try {
        requestToken = await getRequestToken();
        // prettier-ignore
        const redirectUrl = `https://api.twitter.com/oauth/authenticate?oauth_token=${requestToken.token}`
        cb(null, redirectUrl);
    } catch (err) {
        nodecg.log.error('Failed to get Twitter oauth token');
        nodecg.log.error(err);
        cb(err);
    }
});

nodecg.listenFor('twitter:createAccess', async (verifier, cb) => {
    if (!cb || cb.handled) {
        return;
    }

    try {
        const accessToken = await getAccessToken(verifier);
        nodecg.log.info('Set twitter access token');
        nodecg.log.debug(accessToken.token);
        twitterAccess.value.screen_name = accessToken.name;
        twitterAccess.value.access_token = accessToken.token;
        twitterAccess.value.access_secret = accessToken.secret;
        client = new Twitter({
            consumer_key: consumerKey,
            consumer_secret: consumerSecret,
            access_token_key: accessToken.token,
            access_token_secret: accessToken.secret
        });
        nodecg.log.info('Init Twitter Client');
        cb(null, 'success');
    } catch (err) {
        nodecg.log.error('Failed to get Twitter access token');
        nodecg.log.error(err);
        cb(err);
    }
});

nodecg.listenFor('twitter:submitTweet', async (tweetContent, cb) => {
    nodecg.log.info(tweetContent);
    if (!cb || cb.handled) {
        return;
    }
    if (!client) {
        nodecg.log.info('Twitter Client is not init.');
        nodecg.log.info('Try to init client.');
    
        if (twitterAccess.value.access_token && twitterAccess.value.access_secret) {
            client = new Twitter({
                consumer_key: consumerKey,
                consumer_secret: consumerSecret,
                access_token_key: twitterAccess.value.access_token,
                access_token_secret: twitterAccess.value.access_secret
            });
            nodecg.log.info('Init Twitter Client.');
        } else {
            nodecg.log.info('Failed to init Twitter Client.');
            return;
        }
    }

    try {
        client.post('statuses/update', {status: tweetContent}, (error, tweet, response) => {
            if (error) {
                throw error;
            } else {
                cb(null, true);
            }
        })
    } catch (err) {
        nodecg.log.error('Failed to tweet');
        nodecg.log.error(err);
        cb(false);
    }
})
