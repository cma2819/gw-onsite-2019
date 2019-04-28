<setup>
    <div each={detail, idx in details} class="detail {idx} animated fadeInLeft" style="background-image: url(./img/{detail.background})">
        <div id="setup-wrapper">
            <table>
                <tr class="main">
                    <th colspan="2"><img src="./img/game.png" class="othericon" />{detail.name}</th>
                </tr>
                <tr class="sub">
                    <td class="category"><span>{detail.category[0]}</span><span if="{detail.category[1]}">{detail.category[1]}</span></td>
                    <td class="other"><span class="slide runner"><img src="./img/game.png" class="othericon" />{detail.runner}</span>
                        <span class="hidden slide start"><img src="./img/clock.png" class="othericon" />{detail.start}</span></td>
                </tr>
                <tr class="sub">
                    <td>
                        <div class="misc">
                            予定時刻 {detail.start}<br />
                            {detail.description}
                        </div></td>
                </tr>
            </table>
        </div>
    </div>
    <style>
        div {
            overflow-x: hidden;
        }

        div.detail {
            margin: 1em 0;
            color: black;
            background-color: #ffffff;
            box-shadow: 1vw 1vh 1vw;
            border-radius: 0.25vh;
            background-size: cover;
            background-position: center center;
        }

        div.detail:first-child {
            margin-top: 0;
        }

        div.detail:last-child {
            margin-bottom: 0;
        }

        table {
            width: 100%;
            margin: 0 auto;
            text-align: left;
        }

        #setup-wrapper {
            padding: 0.2em;
            background-color: rgba(255, 255, 255, 0.7);
        }

        th,
        td {
            padding-left: 0.5em;
        }

        .main th {
            border-bottom: 0.1em dashed var(--main-color);
        }

        tr.sub td:first-child{
            padding-left: 1em;
        }

        span {
            margin-right: 0.5em;
        }

        tr.sub {
            font-size: 80%;
        }

        td.category {
            width: 60%;
        }

        td.other {
            width: 40%;
            border-left: 0.1em solid var(--main-color);
            position: relative;
            vertical-align: middle;
        }

        .misc {
            border-top: 1px solid var(--main-color);
            display: none;
            overflow-y: hidden;
        }

        span.runner,
        span.start {
            width: 100%;
            position: absolute;
            top: 0px;
            opacity: 1;
            transform: translateX(0px);
            transition: all 500ms 0s ease-out;
        }

        span.hidden {
            opacity: 0;
            transform: translateX(100%);
        }

        img.othericon {
            height: 1em;
            width: 1em;
            margin-right: 0.2em;
        }
    </style>
    <script>
        this.itemlist = opts.itemlist;
        this.current = opts.current;

        // 初期処理
        const setupIdx = parseInt(this.current.idx);
        //const diff = this.setup.result.diff;
        const diff = 0;
        // Setupダッシュボードで情報が設定された次のインデックスから表
        const startIdx = setupIdx;
        this.details = makeDetails(setupIdx, diff, this.itemlist);

        // 表示切替
        const classes = ['.runner', '.start'];
        const hiddenClass = 'hidden';
        const target = '.slide';
        let g_class = 1;
        const classLen = 2;
        setInterval(() => {
            const idx = g_class % 2;
            /*
            $(target).addClass(hiddenClass);
            setTimeout(() => {
                $(classes[idx]).removeClass(hiddenClass);
            }, 1000)
            */
           if (idx == 1) {
               $('.detail.1, .detail.2').removeClass('fadeInLeft').addClass('fadeOutLeft');
               setTimeout(() => {
                   $('.detail.0 .misc').slideDown('slow');
               }, 1000);
           } else {
               $('.detail.0 .misc').slideUp('slow', () => {
                $('.detail.1, .detail.2').removeClass('fadeOutLeft').addClass('fadeInLeft');
               });
           }
            g_class = idx + 1;
        }, 30000);

        observer.on('update-setup', setup => {
            this.setup = setup;
            //this.details = makeDetails(parseInt(setup.result.idx), setup.result.diff, this.itemlist);
            this.details = makeDetails(parseInt(setup.result.idx), 0, this.itemlist);
            this.update();
        })

        observer.on('update-current', current => {
            this.current = current;
            this.details = makeDetails(parseInt(current.idx), 0, this.itemlist);
            this.update();
        })

        function makeDetails(setupIdx, diff, itemlist) {
            // Setupダッシュボードで情報が設定された次のインデックスから表示
            const startIdx = setupIdx;
            const maxIdx = itemlist.length - 1;
            const loop = Math.min((maxIdx - startIdx + 1), 3);
            const details = [];
            for (var i = 0; i < loop; i++) {
                const detail = {};
                detail.name = itemlist[startIdx + i].game;
                detail.category = itemlist[startIdx + i].category.split(' ', 2);
                const runners = [];
                for (var key in itemlist[startIdx + i].players) {
                    if (itemlist[startIdx + i].players[key].name) {
                        runners.push(itemlist[startIdx + i].players[key].name);
                    }
                }
                detail.runner = runners.join('／');
                
                const date = new Date((itemlist[startIdx + i].scheduled_at + diff) * 1000);
                const startDate = getYmdFromDate(date);
                const startTime = getTimeFromDate(date);
                detail.start = startTime + '～';
                detail.description = itemlist[startIdx + i].description;
                detail.background = itemlist[startIdx + i].background;
                details.push(detail);
            }
            return details;
        }
    </script>
</setup>