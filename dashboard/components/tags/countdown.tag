<countdown class="layout horizontal center-center">
    <style>
        #label {
            font-size: 18px;
            text-transform: uppercase;
            margin-left: 32px;
            margin-right: auto;
        }

        #countdownContainer {
            padding-top: 0;
/*            margin-top: -6px;*/
            width: 100px;
        }

    </style>
    <div id="label">Countdown</div>
    <paper-input-container id="countdownContainer" no-label-float attr-for-value="value">
        <time-input
            id="timeInput"
            slot="input"
            class="paper-input-input"
            time="{time}"></time-input>
        <paper-input-error slot="add-on">Invalid time</paper-input-error>
    </paper-input-container>

    <paper-button class="flex layout flex-none" id="start"raised on-tap="start" onclick="{start}" disabled="{running}">
        <iron-icon icon="av:play-arrow"></iron-icon>
        &nbsp;Start
    </paper-button>

    <paper-button class="flex layout flex-none" id="stop" raised on-tap="stop" onclick="{stop}" disabled="{!running}">
        <iron-icon icon="av:stop"></iron-icon>
        &nbsp;Stop
    </paper-button>

    <script>
        this.time = opts.time;
        this.running = opts.running;

        start(e) {
            this.running = true;
            const time = this.time;
            time.formatted = time.minutes + ':' + time.seconds;
            this.trigger('countdown-start', time);
        }

        stop(e) {
            this.running = false;
            this.trigger('countdown-stop');
        }

        this.on('update-time', time => {
            this.time = time;
            this.tags['time-input'].trigger('update-time', time);
            this.update();
        });

        this.on('update-running', running => {
            this.running = running;
            this.update();
        })

        this.on('mount', () => {
            this.tags['time-input'].on('change-minutes', minutes => {
                this.time.minutes = parseInt(minutes);
            });
            this.tags['time-input'].on('change-seconds', seconds => {
                this.time.seconds = parseInt(seconds);
            });
        })

    </script>
</countdown>

<time-input>
    <style>
        :scope {
            display: inline-block;
        }

        iron-input {
            min-width: 1px;
        }

        iron-input input {
            font: inherit;
            outline: none;
            box-shadow: none;
            border: none;
            text-align: center;
            width: 100%;
        }

        #container {
            align-items: baseline;
        }
    </style>
    <div id="container" class="layout horizontal">
        <iron-input class="layout flex" bind-value="{minutes}">
            <input maxlength="2" size="2" aria-label="Minutes" onchange="{changeMinutes}">
        </iron-input>

        <span>:</span>

        <iron-input class="layout flex" bind-value="{seconds}">
            <input maxlength="2" size="2" aria-label="Seconds" onchange="{changeSeconds}">
        </iron-input>
    </div>

    <script>
        this.time = opts.time;
        this.minutes = ('00' + this.time.minutes).slice(-2);
        this.seconds = ('00' + this.time.seconds).slice(-2);

        changeMinutes(e) {
            const minutes = ('00' + e.currentTarget.value).slice(-2);
            this.minutes = minutes;
            this.trigger('change-minutes', minutes);
        }

        changeSeconds(e) {
            const seconds = ('00' + e.currentTarget.value).slice(-2);
            this.seconds = seconds;
            this.trigger('change-seconds', seconds);
        }

        this.on('update-time', time => {
            this.time = time;
            this.minutes = ('00' + time.minutes).slice(-2);
            this.seconds = ('00' + time.seconds).slice(-2);
        });
    </script>
</time-input>