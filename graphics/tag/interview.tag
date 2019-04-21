<telop>
    <div id="telop" class="animated slideInRight" if={visible}>
        <span class="textrow" each={ text, i in texts }>{ text }</span>
    </div>
    <style>
        div {
            display: inline-block;
            position: absolute;
            top: 0px;
            right: 0px;
            min-width: 280px;
            margin: 10px;
            padding: 0.2em 1em;
            background-color: var(--background-black);
            border: 2px solid var(--theme-color);
            box-shadow: var(--shadow);
        }

        span.textrow {
            display: block;
            width: 100%;
            text-align: left;
            font-weight: bold;
        }
    </style>
    <script>
        this.texts = opts.texts;
        this.visible = opts.visible;

        // 初期表示後にAnimatedクラスを除去しておく
        setTimeout(() => {
            $('#telop').removeClass('slideInRight');
        }, 2000);

        observer.on('update-telop', texts => {
            this.texts = texts;
            if (texts && texts.length > 0) {
                this.visible = true;
            } else {
                this.visible = false;
            }
            this.update();
        })

        observer.on('show-telop', () => {
            $('#telop').addClass('slideInRight');
            setTimeout(() => {
                this.update({ visible: true });
                $('#telop').removeClass('slideInRight');
            }, 2000);
        })

        observer.on('hide-telop', () => {
            $('#telop').addClass('slideOutRight');
            setTimeout(() => {
                this.update({ visible: false });
                $('#telop').removeClass('slideOutRight');
            }, 2000);
        })
    </script>

</telop>

<names>
    <div class="parent">
        <div class="child animated fadeInUp" each="{name in names}" style="width:{ childWidth }%">
            <span>{name}</span>
        </div>
    </div>
    <style>
        :scope {
            display: block;
        }

        div.parent {
            width: 80%;
            position: absolute;
            bottom: 20%;
            left: 0px;
            padding: 0 10%;
        }

        div.child {
            float: left;
            width: 30%;
            text-align: center;
        }

        div.child span {
            font-weight: bold;
            color: var(--theme-color);
            background-color: var(--background-black);
            padding: 0.2em 1em;
            border: solid 2px var(--theme-color);
            box-shadow: var(--shadow);
            /*            border-radius: 0.2em;*/
        }
    </style>
    <script>
        this.names = opts.names || [];

        observer.on('update-names', names => {
            this.names = names;
            show(this);
        });

        function show(comp) {
            if (comp.names && comp.names.length != 0) {
                comp.childWidth = 100 / comp.names.length;
            } else {
                comp.childWidth = 50;
            }
            comp.update();
            $('div.child').addClass('fadeInUp').removeClass('fadeOutDown');
            setTimeout(() => {
                $('div.child').removeClass('fadeInUp').addClass('fadeOutDown');
            }, 5000);
        }
    </script>
</names>

<bottom-title>
    <div>
        <p each="{title in titles}">{title}</p>
    </div>
    <style>
        div {
            position: absolute;
            bottom: 5%;
            left: 0;
            width: 100%;
            /* height: 2em; */
            margin: 0px auto;
            border: 2px solid var(--theme-color);
            border-left-width: 0;
            border-right-width: 0;
            box-shadow: var(--shadow);
            background-color: var(--background-black);
            display: none;
        }

        p {
            /*font-weight: bold;*/
            margin: 0.2em 0.5em;
            font-size: 3vh;
        }
    </style>
    <script>
        observer.on('update-title', (titles) => {
            if (titles && titles.length > 0) {
                this.titles = titles;
                this.update();
                $('bottom-title div').fadeIn("normal");
            } else {
                $('bottom-title div').fadeOut("normal", () => {
                    this.titles = titles;
                    this.update();
                });
            }
        });
    </script>
</bottom-title>