<run-editor class="layout vertical center">
    <style>
        :scope {
            font-size: 16px;
        }
        #title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        #run,
        #runners {
            padding: 16px;
        }

        #run {
            margin-right: 4px;
            padding-left: 0;
        }

        #runners {
            border: 1px solid #C1C1C1;
            margin-left: 4px;
        }

        #runners > :nth-child(1) paper-input {
            --paper-input-container-focus-color: #32a7d3;
            --paper-input-container-label: {
                color: #32a7d3;
            };
        }

        #runners > :nth-child(2) paper-input {
            --paper-input-container-focus-color: #fa5959;
            --paper-input-container-label: {
                color: #fa5959;
            };
        }

        #runners > :nth-child(3) paper-input {
            --paper-input-container-focus-color: #24c55d;
            --paper-input-container-label: {
                color: #24c55d;
            };
        }

        #runners > :nth-child(4) paper-input {
            --paper-input-container-focus-color: #dd4dee;
            --paper-input-container-label: {
                color: #dd4dee;
            };
        }

        #buttons {
            margin-top: 16px;
        }

        .row > :not(:last-child) {
            margin-right: 12px;
        }

        .row > :not(:first-child) {
            margin-left: 12px;
        }

        .runner-buttons {
            @apply --layout-horizontal;
        }

        .runner-buttons paper-button {
            padding: 0;
            min-width: 0;
            width: 42px;
            height: 42px;
            --paper-button: {
                color: white;
                background-color: #645BA6;
            }
        }

        paper-checkbox[disabled] {
            background-color: #ffb0b3;
        }
    </style>
    <div id="title">{title}</div>

    <div class="row layout horizontal center">
        <div id="run" class="layout vertical flex">
            <paper-input
                class="layout flex"
                label="Name"
                value="{run.game}"
                onchange="{changeName}"
                hidden="{showingOriginal}"
                always-float-label>
            </paper-input>
            <paper-input
                class="layout flex"
                label="Name"
                value="{original.game}"
                if="{showingOriginal}"
                always-float-label
                disabled>
            </paper-input>

            <paper-input
                class="layout flex"
                label="Category"
                value="{run.category}"
                onchange="{changeCategory}"
                hidden="{showingOriginal}"
                always-float-label>
            </paper-input>
            <paper-input
                class="layout flex"
                label="Category"
                value="{original.category}"
                if="{showingOriginal}"
                always-float-label
                disabled>
            </paper-input>


            <paper-input
                class="layout flex"
                label="Estimate"
                value="{run.estimate}"
                onchange="{changeEstimate}"
                hidden="{showingOriginal}"
                always-float-label>
            </paper-input>
            <paper-input
                class="layout flex"
                label="Estimate"
                value="{original.estimate}"
                if="{showingOriginal}"
                always-float-label
                disabled>
            </paper-input>

            <paper-input
                class="layout flex"
                label="Console"
                value="{run.console}"
                onchange="{changeConsole}"
                hidden="{showingOriginal}"
                always-float-label>
            </paper-input>
            <paper-input
                class="layout flex"
                label="Console"
                value="{original.console}"
                if="{showingOriginal}"
                always-float-label
                disabled>
            </paper-input>

            <div class="row layout horizontal center" style="align-items: center;">
                <div>
                    <paper-checkbox
                        checked="{run.coop}"
                        onchange="{changeCoop}"
                        hidden="{showingOriginal}"
                        disabled="disabled">
                        <span style="white-space: nowrap;">Co-op</span>
                    </paper-checkbox>
                    <paper-checkbox
                        checked="{original.coop}"
                        if="{showingOriginal}"
                        disabled>
                        <span style="white-space: nowrap;">Co-op</span>
                    </paper-checkbox>
                </div>
            </div>
        </div>

        <div id="runners" class="layout vertical frex-2">
            <div class="row layout horizontal center" data-index="0">
                <div class="layout vertical">
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Player"
                                always-float-label
                                value="{run.players.player1.name}"
                                player-index="1"
                                onchange="{changePlayerName}"
                                hidden="{showingOriginal}">
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Player"
                                value="{original.players.player1.name}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{run.players.player1.twitch}"
                                player-index="1"
                                onchange="{changePlayerTwitch}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{original.players.player1.twitch}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                always-float-label
                                value="{run.players.player1.nico}"
                                player-index="1"
                                onchange="{changePlayerNico}"
                                hidden="{showingOriginal}">
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{original.players.player1.nico}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{run.players.player1.twitter}"
                                player-index="1"
                                onchange="{changePlayerTwitter}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{original.players.player1.twitter}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                </div>

                <div class="runner-buttons layout horizontal">
                    <paper-button
                        class="runner-up-button"
                        on-tap="_moveRunnerUp"
                        raised
                        disabled>
                        <iron-icon icon="arrow-upward"></iron-icon>
                    </paper-button>
                    <paper-button
                        class="runner-down-button"
                        on-tap="_moveRunnerDown"
                        raised>
                        <iron-icon icon="arrow-downward"></iron-icon>
                    </paper-button>
                </div>
            </div>

            <div class="row layout horizontal center" data-index="1">
                <div class="layout vertical">
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Player 2"
                                value="{run.players.player2.name}"
                                player-index="2"
                                onchange="{changePlayerName}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Player 2"
                                value="{original.players.player2.name}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{run.players.player2.twitch}"
                                player-index="2"
                                onchange="{changePlayerTwitch}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{original.players.player2.twitch}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{run.players.player2 .nico}"
                                player-index="2"
                                onchange="{changePlayerNico}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{original.players.player2 .nico}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{run.players.player2.twitter}"
                                player-index="2"
                                onchange="{changePlayerTwitter}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{original.players.player2.twitter}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                </div>

                <div class="runner-buttons layout horizontal">
                    <paper-button
                        class="runner-up-button"
                        on-tap="_moveRunnerUp"
                        raised>
                        <iron-icon icon="arrow-upward"></iron-icon>
                    </paper-button>
                    <paper-button
                        class="runner-down-button"
                        on-tap="_moveRunnerDown"
                        raised>
                        <iron-icon icon="arrow-downward"></iron-icon>
                    </paper-button>
                </div>
            </div>

            <div class="row layout horizontal center" data-index="2">
                <div class="layout vertical">
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Player 3"
                                value="{run.players.player3.name}"
                                player-index="3"
                                onchange="{changePlayerName}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Player 3"
                                value="{original.players.player3.name}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{run.players.player3.twitch}"
                                player-index="3"
                                onchange="{changePlayerTwitch}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{original.players.player3.twitch}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{run.players.player3.nico}"
                                player-index="3"
                                onchange="{changePlayerNico}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{original.players.player3.nico}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{run.players.player3.twitter}"
                                player-index="3"
                                onchange="{changePlayerTwitter}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{original.players.player3.twitter}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                </div>

                <div class="runner-buttons layout horizontal">
                    <paper-button
                        class="runner-up-button"
                        on-tap="_moveRunnerUp"
                        raised>
                        <iron-icon icon="arrow-upward"></iron-icon>
                    </paper-button>
                    <paper-button
                        class="runner-down-button"
                        on-tap="_moveRunnerDown"
                        raised>
                        <iron-icon icon="arrow-downward"></iron-icon>
                    </paper-button>
                </div>
            </div>

            <div class="row layout horizontal center" data-index="3">
                <div class="layout vertical">
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Player 4"
                                value="{run.players.player4.name}"
                                player-index="4"
                                onchange="{changePlayerName}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Player 4"
                                value="{original.players.player4.name}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{run.players.player4.twitch}"
                                player-index="4"
                                onchange="{changePlayerTwitch}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitch Channel"
                                value="{original.players.player4.twitch}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                    <div class="row layout horizontal">
                        <div>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{run.players.player4.nico}"
                                player-index="4"
                                onchange="{changePlayerNico}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Niconico Community"
                                value="{original.players.player4.nico}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>

                        <div>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{run.players.player4.twitter}"
                                player-index="4"
                                onchange="{changePlayerTwitter}"
                                hidden="{showingOriginal}"
                                always-float-label>
                            </paper-input>
                            <paper-input
                                class="layout flex"
                                label="Twitter"
                                value="{original.players.player4.twitter}"
                                if="{showingOriginal}"
                                always-float-label
                                disabled>
                            </paper-input>
                        </div>
                    </div>
                </div>  

                <div class="runner-buttons layout horizontal">
                    <paper-button
                        class="runner-up-button"
                        on-tap="_moveRunnerUp"
                        raised>
                        <iron-icon icon="arrow-upward"></iron-icon>
                    </paper-button>
                    <paper-button
                        class="runner-down-button"
                        on-tap="_moveRunnerDown"
                        raised
                        disabled>
                        <iron-icon icon="arrow-downward"></iron-icon>
                    </paper-button>
                </div>
            </div>
        </div>
    </div>

    <div id="buttons" class="layout horizontal">
        <paper-button
            id="resetRun"
            on-tap="resetRun"
            onmouseover="{showOriginal}"
            onmouseout="{hideOriginal}"
            onclick="{resetOriginal}"
            raised>
            RESET DATA TO ORIGINAL
        </paper-button>
        <paper-button
            id="applyChanges"
            on-tap="applyChanges"
            onclick="{applyChanges}"
            raised>
            APPLY CHANGES
        </paper-button>
    </div>

    <script>
        const emptyPlayer = {
            name: '',
            twitch: '',
            nico: '',
            twitter: ''
        };
        this.title = '';
        this.run = {
            game: '',
            category: '',
            console: '',
            estimate: '',
            players: {
                player1: emptyPlayer,
                player2: emptyPlayer,
                player3: emptyPlayer,
                player4: emptyPlayer
            }
        };
        this.showingOriginal = false;

        this.on('set-run-info', (title, run, original, target) => {
            this.title = title;
            this.run = Object.assign({}, run);
            this.original = original;
            this.target = target;
            this.update();
        })

        changeName(e) {
            this.run.game = e.currentTarget.value;
        }

        changeCategory(e) {
            this.run.category = e.currentTarget.value;
        }

        changeConsole(e) {
            this.run.console = e.currentTarget.value;
        }

        changeEstimate(e) {
            this.run.estimate = e.currentTarget.value;
        }

        changePlayerName(e) {
            const key = 'player' + e.currentTarget.attributes['player-index'].value;
            this.run.players[key].name = e.currentTarget.value;
        }

        changePlayerTwitch(e) {
            const key = 'player' + e.currentTarget.attributes['player-index'].value;
            this.run.players[key].twitch = e.currentTarget.value;
        }

        changePlayerNico(e) {
            const key = 'player' + e.currentTarget.attributes['player-index'].value;
            this.run.players[key].nico = e.currentTarget.value;
        }
        
        changePlayerTwitter(e) {
            const key = 'player' + e.currentTarget.attributes['player-index'].value;
            this.run.players[key].twitter = e.currentTarget.value;
        }

        showOriginal(e) {
            this.showingOriginal = true;
        }

        hideOriginal(e) {
            this.showingOriginal = false;
        }

        applyChanges(e) {
            this.trigger('update-run', this.run, this.target);
            this.parent.refs['edit-dialog'].close();
        }

        resetOriginal(e) {
            const _runPlayers = {
                player1: Object.assign(this.run.players.player1, this.original.players.player1),
                player2: Object.assign(this.run.players.player2, this.original.players.player2),
                player3: Object.assign(this.run.players.player3, this.original.players.player3),
                player4: Object.assign(this.run.players.player4, this.original.players.player4)
            }
            this.run = Object.assign(this.run, this.original);
            this.run.players = _runPlayers;
        }
    </script>
</run-editor>