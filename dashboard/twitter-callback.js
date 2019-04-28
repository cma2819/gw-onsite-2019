'use strict'

const modifyCallback = async (query) => {
    const queries = query.split(/[?&]/);
    for (let i = 0; i < queries.length; i++) {
        const key = queries[i].split('=')[0];
        if (key == 'oauth_verifier') {
            const result = await nodecg.sendMessage('twitter:createAccess', queries[i].split('=')[1]);
            return result
        }
    }
}