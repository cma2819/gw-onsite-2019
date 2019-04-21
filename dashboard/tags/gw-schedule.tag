<gw-schedule>
    <schedule current="{current}" next="{next}" typeahead="{typeahead}"></schedule>
    <script>
        this.current = opts.current;
        this.next = opts.next;
        this.schedules = opts.schedules;
        this.typeahead = [];
        for (var i = 0; i < this.schedules.length; i++) {
            this.typeahead.push(this.schedules[i].game);
        }

        // scheduleタグのイベントをハンドリング
        this.on('mount', () => {
            this.tags.schedule.on('prev', () => {
                nodeCgObserver.trigger('schedule-prev');
            });

            this.tags.schedule.on('next', () => {
                nodeCgObserver.trigger('schedule-next');
            });

            this.tags.schedule.on('take', gameName => {
                if (this.typeahead.indexOf(gameName) > -1) {
                    nodeCgObserver.trigger('take-schedule', this.typeahead.indexOf(gameName));
                }
            });

            this.tags.schedule.on('edit-current', run => {
                const _idx = run.idx;
                
                const _runPlayers = Object.assign({}, {
                    player1: Object.assign({}, run.players.player1),
                    player2: Object.assign({}, run.players.player2),
                    player3: Object.assign({}, run.players.player3),
                    player4: Object.assign({}, run.players.player4),
                });
                const _run = Object.assign({}, run);
                _run.players = _runPlayers;
                const _schedulePlayers = assignSchedulePlayers(run.players, this.schedules[_idx].players);
                const _schedule = Object.assign({}, run, {
                    game: this.schedules[_idx].game,
                    category: this.schedules[_idx].category,
                    estimate: this.schedules[_idx].estimate,
                    console: this.schedules[_idx].console,
                    notes: this.schedules[_idx].notes,
                    players: _schedulePlayers
                })
                this.tags.schedule.trigger('show-edit-dialog', 'Edit Current Run(#' + _idx + ')', _run, _schedule, 'current');
            });

            this.tags.schedule.on('edit-next', run => {
                const _idx = run.idx;

                const _runPlayers = Object.assign({}, {
                    player1: Object.assign({}, run.players.player1),
                    player2: Object.assign({}, run.players.player2),
                    player3: Object.assign({}, run.players.player3),
                    player4: Object.assign({}, run.players.player4),
                });
                const _run = Object.assign({}, run);
                _run.players = _runPlayers;
                const _schedulePlayers = assignSchedulePlayers(run.players, this.schedules[_idx].players);
                const _schedule = Object.assign({}, run, {
                    game: this.schedules[_idx].game,
                    category: this.schedules[_idx].category,
                    estimate: this.schedules[_idx].estimate,
                    console: this.schedules[_idx].console,
                    notes: this.schedules[_idx].notes,
                    players: _schedulePlayers
                })
                this.tags.schedule.trigger('show-edit-dialog', 'Edit Next Run(#' + _idx + ')', _run, _schedule, 'next');
            });

            this.tags.schedule.on('update-current-run', run => {
                nodeCgObserver.trigger('edit-current-run', run);
            });

            this.tags.schedule.on('update-next-run', run => {
                nodeCgObserver.trigger('edit-next-run', run);
            })
        })

        nodeCgObserver.on('update-current-run', current => {
            this.current = current;
            this.tags.schedule.trigger('update-current', current);
        })
        nodeCgObserver.on('update-next-run', next => {
            this.next = next;
            this.tags.schedule.trigger('update-next', next);
        })
    </script>
</gw-schedule>