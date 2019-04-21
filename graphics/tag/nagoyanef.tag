


<!-- セットアップ画面情報タグ -->
<setup-info>
    <div>
        <h1>C4RUN RTAリレー</h1>
        <p class="label">Up Next</p>
        <dl>
            <dt>Game</dt>
            <dd>{game}</dd>
            <dt>Category</dt>
            <dd>{category}</dd>
            <dt>Player</dt>
            <dd>{player}</dd>
            <dt>Estimate</dt>
            <dd>{estimate}</dd>
        </dl>
    </div>
    <style>
        div {
            position: absolute;
            top: 50px;
            left: 75px;
            width: 720px;
            border: 4px #ffcd00 solid;
            border-radius: 5px;
            padding: 5px 0.5em;
        }

        h1 {
            font-size: 48px;
        }

        p.label {
            border-bottom: 2px #ffcd00 solid;
            font-size: 24px;
            margin-bottom: 5px;
            text-align: right;
        }

        dl {
            margin: 0px 20px;
            font-size: 28px;
            font-weight: bold;
        }

        dt {
            margin: 0.1em 0px;
        }

        dt {
            padding: 0.1em 0.2em;
            background-color: rgba(255, 205, 0, 1.0);
            border-radius: 0.2em;
            display: inline-block;
            margin-top: 0.25em;
        }

        dd {
            margin: 0px;
            margin-left: 0.5em;
        }
    </style>
    <script>
        // Get Observer | Observerの取得
        this.observer = opts.observer;

        // Set Listener to update values | 値更新時のイベントリスナ定義
        this.observer.on('update:setup-info', (data) => {
            this.game = data.game || 'no game';
            this.category = data.category || 'no category';
            this.player = data.player || 'no player';
            this.estimate = data.estimate || '99:99:99';
            this.update();
        });
    </script>
</setup-info>