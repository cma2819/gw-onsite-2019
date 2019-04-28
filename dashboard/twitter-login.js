'use strict'

// Replicant
const twitterToken = nodecg.Replicant('twitter-token');

nodecg.readReplicant('twitter-token', token => {
    if (token.screen_name) {
        document.getElementById('twitter-name').textContent = 'ログイン中：' + token.screen_name;
    } else {
        document.getElementById('twitter-name').textContent = '';
    }
});

twitterToken.on('change', newToken => {
    if (newToken.screen_name) {
        document.getElementById('twitter-name').textContent = 'ログイン中：' + newToken.screen_name;
    } else {
        document.getElementById('twitter-name').textContent = '';
    }
})


const login = async () => {
    const url = await nodecg.sendMessage('twitter:startLogin');
    window.parent.location.replace(url);
}

const modifyCallback = async (query) => {
    const queries = query.split(/[?&]/);
    for (let i = 0; i < queries.length; i++) {
        const key = queries[i].split('=')[0];
        if (key == 'oauth_verifier') {
            const result = await nodecg.sendMessage('twitter:createAccess', queries[i].split('=')[1]);
            return result;
        }
    }
}
if (localStorage.getItem('twitter-callback')) {
    console.log('Twitter Status:' + modifyCallback(localStorage.getItem('twitter-callback')));
    localStorage.removeItem('twitter-callback');
}
