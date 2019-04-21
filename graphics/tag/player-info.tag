<!-- プレイ中画面プレイヤー情報タグ -->
<player-info>
    <table id="player-table">
        <tr each="{info in infos}">
            <th if={info.label}>
                {info.label}
            </th>
            <td class="name">{info.name}</td>
            <td class="sns">
                <span class="sns_content{preClass} twitch{preClass}" if={info.twitch}><img src="./img/icon_twitch.png" height="24px"
                        width="24px" />
                    {info.twitch}</span>
                <span class="sns_content{preClass} twitter{preClass}" if={info.twitter}><img src="./img/icon_twitter.png" height="24px"
                        width="24px" /> {info.twitter}</span>
            </td>
        </tr>
    </table>
    <div class="back">{subinfo}</div>
    <!--
            <dl>
                <dt>Runner</dt>
                <span each="{runner in runners}">
                    <dd>{runner.name}</dd>
                    <dd class="sns"><img src="./img/icon_twitter.png" height="24px" width="24px" />{runner.twitter}</dd>
                    <dd class="sns"><img src="./img/icon_twitch.png" height="24px" width="24px" />{runner.twitch}</dd>
                </span>
            </dl>
    -->
    <style>
        :scope {
            display: block;
        }

        #player-table {
            width: 100%;
            margin: 0 auto;
            border-collapse: collapse;
            table-layout: fixed;
        }

        dl {
            margin: 0px;
        }

        th {
            padding-left: 1em;
            border-bottom: 2px var(--theme-color) solid;
            text-align: left;
        }

        td {
            border-bottom: 2px var(--theme-color) solid;
        }

        .name {
            padding-left: 2em;
            text-align: left;
        }

        .sns {
            text-align: right;
            vertical-align: bottom;
            font-size: 80%;
            padding-right: 1em;
            /*            width: 20%;*/
        }

        .sns span {
            display: none;
        }

        .back {
            opacity: 0.8;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            font-weight: bold;
            text-align: center;
        }
    </style>
    <script>
        // 初期化
        this.infos = opts.infos;
        this.subinfo = opts.subinfo || '';
        this.idx = opts.idx || -1;
        if (this.idx > 0) {
            this.preClass = this.idx;
        } else {
            this.preClass = '';
        }

        // SNS情報の切り替え用
        this.g_sns = 0;
        this.snsClasses = [];
        for (var i = 0; i < this.infos.length; i++) {
            if (this.snsClasses.indexOf('twitch' + this.preClass) < 0 && this.infos[i].twitch) {
                this.snsClasses.push('twitch' + this.preClass);
            }
            if (this.snsClasses.indexOf('nico' + this.preClass) < 0 && this.infos[i].nico) {
                this.snsClasses.push('nico' + this.preClass);
            }
            if (this.snsClasses.indexOf('twitter' + this.preClass) < 0 && this.infos[i].twitter) {
                this.snsClasses.push('twitter' + this.preClass);
            }
        }

        // Set Listener to update values | 値更新時のイベントリスナ定義
        observer.on('update:player-info', (data) => {
            this.infos = data;
            this.snsClasses = [];
            for (var i = 0; i < this.infos.length; i++) {
                if (this.snsClasses.indexOf('twitch' + this.preClass) < 0 && this.infos[i].twitch) {
                    this.snsClasses.push('twitch' + this.preClass);
                }
                if (this.snsClasses.indexOf('nico' + this.preClass) < 0 && this.infos[i].nico) {
                    this.snsClasses.push('nico' + this.preClass);
                }
                if (this.snsClasses.indexOf('twitter' + this.preClass) < 0 && this.infos[i].twitter) {
                    this.snsClasses.push('twitter' + this.preClass);
                }
            }
            this.update();
        });

        observer.on('update:player-info-race', (data, idx, subinfo) => {
            if (idx == this.idx) {
                this.infos = data;
                this.subinfo = subinfo;
                this.snsClasses = [];
                for (var i = 0; i < this.infos.length; i++) {
                    if (this.snsClasses.indexOf('twitch' + this.preClass) < 0 && this.infos[i].twitch) {
                        this.snsClasses.push('twitch' + this.preClass);
                    }
                    if (this.snsClasses.indexOf('nico' + this.preClass) < 0 && this.infos[i].nico) {
                        this.snsClasses.push('nico' + this.preClass);
                    }
                    if (this.snsClasses.indexOf('twitter' + this.preClass) < 0 && this.infos[i].twitter) {
                        this.snsClasses.push('twitter' + this.preClass);
                    }
                }
                this.update();
            }
        });

        function toggleSns(cmp) {
            const next = cmp.g_sns % (cmp.snsClasses.length);
            if (cmp.snsClasses.length != 1) {
                $('.sns_content' + cmp.preClass).fadeOut('slow', () => {
                    setTimeout(() => {
                        $('.' + cmp.snsClasses[next]).fadeIn('slow');
                    }, 1000);
                })
                cmp.g_sns = next + 1;
            } else {
                if (!$('.' + cmp.snsClasses[next]).is(':visible')) {
                    $('.' + cmp.snsClasses[next]).fadeIn('slow');
                }
            }
        }
        setInterval(toggleSns, 10000, this);


    </script>
</player-info>