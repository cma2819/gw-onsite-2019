// Twitter管理用Observer
const twitterObserver = riot.observable();

riot.mount('gw-twitter');

// Tweetイベント
twitterObserver.on('submit', async content => {
    const result = await nodecg.sendMessage('twitter:submitTweet', content);
    if (result) {
        twitterObserver.trigger('update-status', 'ツイートが完了しました');
    } else {
        twitterObserver.trigger('update-status', 'ツイートに失敗しました');
    }
})