<schedule class="layout vertical">
    <style>
        :scope {
            padding: 22px 21px;
        }

        #selection-ctrls {
            margin-bottom: 16px;
        }

        #selection-ctrls > paper-button {
            height: 64px;
        }
        
        #typeahead {
            width: 100%;
            margin-top: -26px;
        }

        #runs-spacer {
            width: 18px;
        }

        #edit-ctrls > paper-button {
            height: 32px;
        }

        #previous,
        #editCurrent {
            margin-left: 0;
        }

        #next,
        #editNext {
            margin-right: 0;
        }

    </style>
    <div id="selection-ctrls" class="layout horizontal start">
            <paper-button id="previous" on-tap="previous" onclick="{prev}" raised>
                <iron-icon icon="arrow-back"></iron-icon>
                Prev
            </paper-button>

            <div id="typeahead-container" class="layout flex">
                <vaadin-combo-box
                    id="typeahead"
                    placeholder="Search"
                    on-keyup="_typeaheadKeyup"
                    onchange="{changeTypeahead}"
                    ref="typeahead">
                </vaadin-combo-box>

                <paper-button id="take" on-tap="takeTypeahead" disabled="{typeDisabled}" onclick="{take}" raised>
                    <span>Take</span>
                    <iron-icon icon="chevron-right"></iron-icon>
                </paper-button>
            </div>

            <paper-button id="next" on-tap="next" onclick="{next}" raised>
                Next
                <iron-icon icon="arrow-forward"></iron-icon>
            </paper-button>
        </div>

        <div id="runs" class="layout horizontal">
            <schedule-runinfo id="currentRun" label="Current Run" run="{currentRun}" players="{currentRun.players}" ref="current-info"></schedule-runinfo>
            <div id="runs-spacer"></div>
            <schedule-runinfo id="nextRun" label="Next Run" run="{nextRun}" players="{nextRun.players}" ref="next-info"></schedule-runinfo>
        </div>

        <div id="edit-ctrls">
            <paper-button id="editCurrent" raised on-tap="editCurrent" onclick="{editCurrent}">EDIT CURRENT</paper-button>
            <paper-button id="fetchLatestSchedule" raised on-tap="fetchLatestSchedule" disabled="disabled">FETCH SCHEDULE</paper-button>
            <paper-button id="editNext" raised on-tap="editNext" onclick="{editNext}">EDIT NEXT</paper-button>
        </div>

        <paper-dialog id="editDialog" ref="edit-dialog" with-backdrop>
            <run-editor id="editor" ref="editor"></run-editor>
            <div class="buttons">
                <paper-button dialog-dismiss autofocus>Cancel</paper-button>
            </div>
        </paper-dialog>

        <script>
            this.currentRun = opts.current;
            this.nextRun = opts.next;
            this.typeahead = opts.typeahead;
            this.typeDisabled = true;
            this.on('mount', () => {
                document.getElementById('typeahead').items = this.typeahead;
            });

            changeTypeahead(e) {
                const game = e.currentTarget.value;
                if (this.typeahead.indexOf(game) < 0) {
                    this.typeDisabled = true;
                } else {
                    this.typeDisabled = false;
                }

            }

            prev(e) {
                this.trigger('prev');
            }

            next(e) {
                this.trigger('next');
            }

            take(e) {
                const conf = window.confirm('現在のスケジュールを「' + this.refs['typeahead'].value + '」まで飛ばします。\n表示中のスケジュールへの変更は消去されます。');
                if (conf) {
                    this.trigger('take', this.refs['typeahead'].value);
                    this.refs['typeahead'].value = '';
                    this.typeDisabled = true;
                }
            }

            editCurrent(e) {
                this.trigger('edit-current', this.currentRun);
            }

            editNext(e) {
                this.trigger('edit-next', this.nextRun);
            }

            this.on('update-current', current => {
                this.currentRun = current;
                this.refs['current-info'].trigger('update-info', this.currentRun, this.currentRun.players);
            });
            this.on('update-next', next => {
                this.nextRun = next;
                this.refs['next-info'].trigger('update-info', this.nextRun, this.nextRun.players);
            });

            this.on('show-edit-dialog', (title, run, original, target) => {
                this.refs['editor'].trigger('set-run-info', title, run, original, target);
                this.refs['edit-dialog'].open();
            });

            this.on('mount', () => {
                this.refs['editor'].on('update-run', (run, target) => {
                    if (target == 'current') {
                        this.trigger('update-current-run', run);
                    } else {
                        this.trigger('update-next-run', run);
                    }
                });
            })

        </script>
</schedule>

<schedule-runinfo class="layout vertical flex">
    <style>
        #label {
            background: #8C8C8C;
            color: white;
            font-size: 18px;
            font-weight: 500;
            height: 26px;
            text-align: center;
            width: 100%;
        }

        .padded {
            padding: 4px;
        }

        .modified {
            background-color: #CEE0C9;
        }

        .modified label:after {
            content: '*';
        }

        .divider {
            border-bottom: 1px dashed var(--gdq-schedule-runinfo-color, black);
            margin-top: 10px;
            margin-bottom: 10px;
        }

        #name .value {
            font-weight: 500;
            font-size: 18px;
            height: 2.4em;
            word-wrap: break-word;
            white-space: normal;

            /* limit max lines to 2 */
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        #console {
            overflow: hidden;
            white-space: nowrap;
        }

        #notes .value {
            white-space: normal;
            height: 5em;
            overflow-y: auto;
            word-wrap: break-word;
        }

        label {
            font-size: 13px;
        }

        .value {
            font-size: 16px;
            font-weight: 500;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
            display: inline-block;
        }

    </style>
		<div id="label" class="layout center-center horizontal">#{run.idx}</div>

		<section id="name" class="padded" class="layput vertical">
			<label>Name</label>
			<span class="value" title="name">{run.game}</span>
		</section>

		<div class="divider"></div>

		<section id="runners" class="layout horizontal wrap">
			<div class="padded runner layout vertical" style="margin-bottom: 12px;" if={players.player1.name}>
				<label>Runner</label>
				<span class="value" title="{players.player1.name}">{players.player1.name}&#8203;</span>
			</div>
			<div class="padded runner layout vertical" style="margin-bottom: 12px;" if={players.player2.name}>
				<label>Runner 2</label>
				<span class="value" title="{players.player2.name}">{players.player2.name}&#8203;</span>
			</div>
			<div class="padded runner layout vertical" if={players.player3.name}>
				<label>Runner 3</label>
                <span class="value" title="{players.player3.name}">{players.player3.name}&#8203;</span>
			</div>
			<div class="padded runner layout vertical" if={players.player4.name}>
				<label>Runner 4</label>
				<span class="value" title="{players.player4.name}">{players.player4.name}&#8203;</span>
			</div>
		</section>

		<div class="divider"></div>

		<section class="padded layout vertical">
			<label>Category</label>
			<span class="value" title="{run.category}">{run.category}&#8203;</span>
		</section>

		<div class="divider"></div>

		<section id="misc" class="layout horizontal justified">
			<div class="padded layout vertical">
				<label>Estimate</label>
				<span class="value">{run.estimate}&#8203;</span>
			</div>
			<div id="console" class="padded layout vertical">
				<label>Console</label>
				<span title="{console}" class="value">{run.console}&#8203;</span>
			</div>
			<div class="padded [[calcModified(originalValues.coop)]] layout vertical">
				<label>Co-op</label>
				<span class="value">{}&#8203;</span>
			</div>
		</section>

		<div class="divider"></div>

		<section id="notes" class="padded layout vertical">
			<label>Tech Notes</label>
			<div class="value"></div>
        </section>
        
        <script>
            this.run = opts.run;
            this.players = opts.players;

            this.on('update-info', (run, players) => {
                this.update({run:run, players:players});
            })
        </script>
</schedule-runinfo>