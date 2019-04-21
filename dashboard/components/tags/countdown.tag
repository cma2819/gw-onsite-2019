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
    <paper-input-container id="countdownContainer" no-label-float auto-validate attr-for-value="value">
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
        this.observer = opts.observer;
        this.time = opts.time;
        this.running = opts.running;

        start(e) {
            this.running = true;
            this.observer.trigger('countdown', true);
        }

        stop(e) {
            this.running = false;
            this.observer.trigger('countdown', false);
        }

        this.observer.on('update-countdown', time => {
            this.time.minutes = time.minutes || 0;
            this.time.seconds = time.seconds || 0;
            this.update();
        });

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
        <iron-input class="layout flex" bind-value="{time.minutes}">
            <input maxlength="2" size="2" aria-label="Minutes">
        </iron-input>

        <span>:</span>

        <iron-input class="layout flex" bind-value="{time.seconds}">
            <input maxlength="2" size="2" aria-label="Seconds">
        </iron-input>
    </div>

    <script>
        this.time = opts.time;
    </script>
</time-input>