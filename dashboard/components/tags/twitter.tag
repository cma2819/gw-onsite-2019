<twitter-submit class="layout vertical">
    <style>
        paper-button {
            text-align: center;
        }
    </style>
    <paper-input
        class="layout flex"
        label="ハッシュタグ"
        value="{hashTag}"
        disabled="{!tagEnabled}"
        onchange="{tagChange}">
        <div slot="prefix">#</div>
    </paper-input>
    <paper-checkbox
        checked="{tagEnabled}"
        onchange="{changeEnableTag}">
        Enable Hashtag
    </paper-checkbox>
    <paper-input
        class="layout flex"
        label="埋め込み：{bindTemp}"
        value="{bindedText}"
        onchange="{bindChange}">
    </paper-input>
    <paper-textarea
        class="layout flex"
        label="Tweet"
        rows="5"
        ref="tweet-text"></paper-textarea>
    <paper-button raised onclick="{bindText}">埋め込み文字追加</paper-button>
    <paper-button raised onclick="{submitTweet}">投稿</paper-button>
    <paper-input
        class="layout flex"
        label="Status"
        readonly="readonly"
        ref="status-input">
        <paper-button slot="suffix" onclick="{deleteStatus}">×</paper-button>
</paper-input>

    <script>
        this.hashTag = 'ZeldaRTA_GW2019';
        this.bindedText = '';
        this.tagEnabled = true;
        this.bindTemp = '{_time_}'
        changeEnableTag(e) {
            this.tagEnabled = e.currentTarget.checked;
        }

        tagChange(e) {
            this.hashTag = e.currentTarget.value;
        }

        bindChange(e) {
            this.bindedText = e.currentTarget.value;
        }

        bindText(e) {
            const before = this.refs['tweet-text'].value || '';
            //this.refs['tweet-text'].value = before + this.bindText;
            this.refs['tweet-text'].value = before + this.bindTemp;
        }

        submitTweet(e) {
            const tweetContent = this.refs['tweet-text'].value || '';
            if (tweetContent == '') {
                this.refs['status-input'].value = 'ツイート内容が入力されていません.';
                return;
            }
            const bindedTweet = tweetContent.split(this.bindTemp).join(this.bindedText || '');
            if (this.tagEnabled && this.hashTag) {
                this.trigger('tweet', bindedTweet + '\n#' + this.hashTag);
            } else {
                this.trigger('tweet', bindedTweet);
            }
            this.refs['status-input'].value = 'ツイートを投稿しています...';
        }

        deleteStatus(e) {
            this.refs['status-input'].value = '';
        }

        this.on('update-status', status => {
            this.refs['status-input'].value = status;
        })
    </script>
</twitter-submit>