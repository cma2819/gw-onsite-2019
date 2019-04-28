<gw-twitter>
    <div class="title">Tweet投稿</div>
    <twitter-submit></twitter-submit>
    <script>
        this.on('mount', () => {
            this.tags['twitter-submit'].on('tweet', content => {
                twitterObserver.trigger('submit', content);
            })
        })
        twitterObserver.on('update-status', status => {
            this.tags['twitter-submit'].trigger('update-status', status);
        })
    </script>
</gw-twitter>