<timekeeper class="layout vertical">
    <style>
        :scope {
            color: white;
            background-color: #bcbcff;
            width: 100%;
            font-family: 'roboto', sans-serif;
            white-space: nowrap;
            height: 447px;
        }

        timekeeper-runner {
            border-bottom: 1px solid black;
        }

        timekeeper-runner:last-child {
            border-bottom: none;
        }
    </style>
    <div id="timer" class="layout horizontal center around-justified flex-none">
        <span id="timer-time">{time}</span>

        <div class="layout vertical">
            <div class="layout horizontal">
                <paper-button raised class="green" on-tap="startTimer" onclick="{start}" disabled="{calcStartDisabled()}"
                    ref="start-button">
                    <iron-icon icon="av:play-arrow" title="Start"></iron-icon>
                    &nbsp;Start
                </paper-button>

                <paper-button raised class="yellow" on-tap="stopTimer" onclick="{stop}" disabled="{!isrunning}" ref="stop-button">
                    <iron-icon icon="av:pause" title="Pause Timer"></iron-icon>
                    &nbsp;Pause
                </paper-button>
            </div>

            <div class="layout horizontal">
                <paper-button raised class="purple" on-tap="confirmReset" onclick="{confirmReset}">
                    <iron-icon icon="refresh" title="Reset"></iron-icon>
                    &nbsp;Reset
                </paper-button>

                <paper-button raised class="purple" on-tap="editMasterTime" disabled="{isrunning}" ref="edit-button" onclick="{openEdit}">
                    <iron-icon icon="editor:mode-edit" title="Edit"></iron-icon>
                    &nbsp;Edit
                </paper-button>
            </div>
        </div>
    </div>

    <timekeeper-runner each="{runner, idx in runners}" runner="{runner}" runner-idx="player{idx+1}">;
    </timekeeper-runner>

    <paper-dialog id="editDialog" ref="edit-dialog" with-backdrop>
        <p id="editDialog-text"></p>
        <paper-input
            id="editDialog-input"
            ref="edit-input"
            player-idx="master"
            label="Final Time"
            placeholder="00:00:00.00"
            auto-validate></paper-input>
        <div class="buttons">
            <paper-button dialog-confirm on-tap="saveEditedTime" onclick="{editTime}">Save</paper-button>
            <paper-button dialog-dismiss autofocus>Cancel</paper-button>
        </div>
    </paper-dialog>

    <script>
        this.time = opts.time;
        this.ready = false;
        this.isrunning = false;
        this.runners = opts.runners;

        calcStartDisabled() {
            if (this.ready && !this.isrunning) {
                return false;
            } else {
                return true;
            }
            return true;
        }

        calcPauseDisabled() {
            if (this.isrunning) {
                return false;
            } else {
                return true;
            }
        }

        checklistIncomplete() {
            for (var key in this.runners) {
                if (this.runners[key] && this.runners[key].time == '') {
                    return true;
                }
            }
            return false;
        }

        this.on('update-ready', ready => {
            this.ready = ready;
            this.update();
        });

        this.on('time-changed', time => {
            if (this.isrunning) {
                this.time = time;
                this.update();
            }
        });

        this.on('update-runners', runners => {
            this.runners = runners;
            this.update();
        })

        this.on('mount', () => {
            this.tags['timekeeper-runner'].forEach(el => {
                el.on('runner-finish', () => {
                    el.runner.time = this.time;
                    el.update();
                    // 全プレイヤーがFinishしたらFinishするようにする
                    if (!this.checklistIncomplete()) {
                        this.stop();
                        this.update();
                    }
                });
                el.on('runner-resume', () => {
                    el.runner.time = '';
                    el.update();
                });
                el.on('edit-time', (index, time)=> {
                    this.refs['edit-input'].attributes['player-idx'].value = index;
                    this.refs['edit-input'].value = time;
                    this.refs['edit-dialog'].open();
                });
            });
        });

        start(e) {
            this.trigger('start-timer');
            this.isrunning = true;
        }

        stop(e) {
            this.trigger('stop-timer');
            this.isrunning = false;
        }

        confirmReset(e) {
            if (window.confirm('タイムとチェックリストをリセットします。リセットしたタイムは元に戻せません。')) {
                this.trigger('reset-timer');
                this.time = '00:00.0';
                this.isrunning = false;
                this.ready = false;
                this.tags['timekeeper-runner'].forEach(el => {
                    el.trigger('reset');
                });
            }
        }

        openEdit(e) {
            this.refs['edit-input'].attributes['player-idx'].value = 'master';
            this.refs['edit-input'].value = this.time;
            this.refs['edit-dialog'].open();
        }

        editTime(e) {
            this.trigger('edit-time', this.refs['edit-input'].attributes['player-idx'].value,
                            this.refs['edit-input'].value);
        }
    </script>
</timekeeper>

<timekeeper-runner class="layout horizontal center justified">
    <style>
        :scope {
            background-color: #dedede;
            flex-basis: 130px;
            padding-left: 18px;
            padding-right: 8px;
            flex-grow: 1;
            flex-shrink: 1;
        }
    </style>
    <div id="info" if="{runner}">
        <sc-fitted-text id="info-name" align="left" max-width="180" text="{runner.name}" title="{runner.name}">
        </sc-fitted-text>
        <div id="info-status">
            {calcInfoText()}
        </div>
    </div>

    <div id="buttons" if="{runner}">
        <paper-button raised class="green" on-tap="finish" onclick="{finish}" hidden="{calcFinishHidden()}">
            &nbsp;Finish
        </paper-button>

        <paper-button raised class="yellow" on-tap="resume" onclick="{resume}" hidden="{calcResumeHidden()}">
            &nbsp;Resume
        </paper-button>

        <paper-button raised class="gray" on-tap="forfeit" onclick="{forfeit}" hidden="{calcForfeitHidden()}">
            &nbsp;Forfeit
        </paper-button>

        <paper-button raised class="purple" on-tap="editTime" onclick="{edit}" disabled="{calcEditDisabled()}" ref="edit-button">
            &nbsp;Edit
        </paper-button>
    </div>

    <div id="empty" hide="{runner}">- EMPTY SLOT -</div>
    <script>
        this.idx = opts['runner-idx'];
        this.runner = opts.runner;

        finish(e) {
            this.trigger('runner-finish');
            this.runner.state = 'finished';
            this.refs['edit-button'].disabled = this.calcEditDisabled();
        }

        resume(e) {
            this.trigger('runner-resume');
            this.runner.time = '';
            this.runner.state = 'running';
            this.refs['edit-button'].disabled = this.calcEditDisabled();
        }

        forfeit(e) {
            this.runner.time = '';
            this.runner.state = 'forfeit';
        }

        edit(e) {
            this.trigger('edit-time', this.idx, this.runner.time);
        }

        calcFinishHidden() {
            if (this.runner.state == 'finished') {
                return true;
            } else {
                return false;
            }
        }

        calcResumeHidden() {
            if (this.runner.state == 'running') {
                return true;
            } else {
                return false;
            }
        }

        calcForfeitHidden() {
            if (this.runner.state == 'forfeit') {
                return true;
            } else {
                return false;
            }
        }

        calcEditDisabled() {
            if (this.runner.time == '') {
                return true;
            } else {
                return false;
            }
        }

        calcInfoText() {
            if (this.runner.time == '') {
                return this.runner.state;
            } else {
                return this.runner.time;
            }
        }

        this.on('reset', () => {
            if (this.runner) {
                this.runner.time = '';
                this.runner.state = 'running';
                this.update();
            }
        })
    </script>
</timekeeper-runner>