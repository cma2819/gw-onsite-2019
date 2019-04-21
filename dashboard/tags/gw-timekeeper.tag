<gw-timekeeper>
    <style>
        #time-checklist {
            padding: 10px;
            border-top: 1px solid black;
        }
    </style>
    <div class="title">ストップウォッチ</div>
    <timekeeper
        ref="timekeeper"
        runners="{runners}"
        time="{time}"></timekeeper>
    <div id="time-checklist">
        <checklist
            ref="run-checklist"
            content="{checklist}"></checklist>
    </div>

    <script>
        this.checklist = [
            {
                label: 'チェックリスト',
                checks: [
                    '配信レイアウトが正常', '音声バランスの確認', 'Twitchダッシュボードの更新', '走者の準備完了'
                ]
            }
        ]
        this.runners = {
            player1: opts.players.player1.name? Object.assign({}, opts.players.player1): null,
            player2: opts.players.player2.name? Object.assign({}, opts.players.player2): null,
            player3: opts.players.player3.name? Object.assign({}, opts.players.player3): null,
            player4: opts.players.player4.name? Object.assign({}, opts.players.player4): null,
            };
        this.time = opts.time;

        this.on('mount', () => {
            this.refs['run-checklist'].on('change-checklist', isAllChecked => {
                this.refs['timekeeper'].trigger('update-ready', isAllChecked);
            });

            this.refs['timekeeper'].on('start-timer', () => {
                nodeCgObserver.trigger('start-timer');
            });
            this.refs['timekeeper'].on('stop-timer', () => {
                nodeCgObserver.trigger('stop-timer');
            });
            this.refs['timekeeper'].on('reset-timer', () => {
                this.refs['run-checklist'].trigger('reset-checklist');
                nodeCgObserver.trigger('reset-timer');
            });
            this.refs['timekeeper'].on('edit-time', (index, time) => {
                nodeCgObserver.trigger('edit-master-time', index, time);
            })
        });

        nodeCgObserver.on('update-current-run', currentRun => {
            const _runners = {
                player1: currentRun.players.player1.name? Object.assign({}, currentRun.players.player1): null,
                player2: currentRun.players.player2.name? Object.assign({}, currentRun.players.player2): null,
                player3: currentRun.players.player3.name? Object.assign({}, currentRun.players.player3): null,
                player4: currentRun.players.player4.name? Object.assign({}, currentRun.players.player4): null,
            }
            this.refs['timekeeper'].trigger('update-runners', _runners);
        })
        nodeCgObserver.on('time-changed', time => {
            this.refs['timekeeper'].trigger('time-changed', time);
        })

    </script>
</gw-timekeeper>