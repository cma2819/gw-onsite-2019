<!-- プレイ中画面RTA情報タグ -->
<run-info>
    <table id="run-table">
        <tr id="run-main">
<!--            <th colspan="2"><span>{game[0]}</span><span if={game[1]}>{game[1]}</span></th>-->
            <th>{run.game}</th>
        </tr>
        <tr id="run-sub">
            <!--            <td id="sub-left"><span>{category[0]}</span><span if={category[1]}>{category[1]}</span></td>-->
            <td id="sub-right">{run.platform}</td>
        </tr>
    </table>

    <style>
        :scope {
            display: block;
            /*height: 100px;*/
        }

        #run-table {
            table-layout: auto;
            width: 100%;
            margin: 0 auto;
            border-collapse: collapse;
        }

        #run-main {
            text-align: center;
            vertical-align: middle;
        }

        #run-main th {
            border-bottom: 2px var(--theme-color) solid;
        }

        #run-sub {
            font-size: 80%;
            text-align: center;
            vertical-align: middle;
        }

        td#sub-left {
            border-right: 2px var(--theme-color) solid;
            width: 70%;
        }

        span {
            display: inline-block;
            margin: 0 0.2em;
        }

        span.icon {
            background-color: var(--theme-color);
            border-radius: 10px;
            padding: 0px 0.4em;
        }
    </style>
    <script>
        // 初期化
        /*
        this.game = opts.run.game.split(' ', 2);
        this.platform = opts.run.platform;
        */
        this.run = opts.run;

        // Set listener to update values | 値更新時のイベントリスナ定義
        observer.on('update-run-info', (data) => {
            this.run = data;
            /*
            this.game = data.game.split(' ', 2);
            this.platform = data.platform;
            */
            this.update();
        });
    </script>
</run-info>