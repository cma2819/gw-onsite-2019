// Observer - RiotタグとNodeCGの連携を行うObserverを定義
const nodeCgObserver = riot.observable();

// Configuration
const gwSchedule = nodecg.bundleConfig.schedule;

// Replicant
const currentRun = nodecg.Replicant('current-run');
const nextRun = nodecg.Replicant('next-run');

// 初期表示
nodecg.readReplicant('current-run', currentRunValue => {
    // インデックスが初期値(-1)の場合
    if (currentRunValue.idx == -1) {
        // スケジュール設定値で初期化
        const _idx = 1;
        _currentRun = {
            idx: _idx,
            game: gwSchedule[_idx].game,
            category: gwSchedule[_idx].category,
            estimate: gwSchedule[_idx].estimate,
            console: gwSchedule[_idx].console,
            notes: gwSchedule[_idx].notes
        }
        const currentSchedulePlayers = gwSchedule[_idx].players;
        const _currentPlayers = assignSchedulePlayers(currentRunValue.players, currentSchedulePlayers);
    
        _currentRun.players = _currentPlayers;
        currentRun.value = _currentRun;
    } else {
        _currentRun = currentRunValue;
    }
    nodecg.readReplicant('next-run', nextRunValue => {
        let _nextRun = {};
        // インデックスが初期値(-1)の場合
        if (nextRunValue.idx == -1) {
            // スケジュール設定値で初期化
            _nextRun = {
                idx: _currentRun.idx + 1,
                game: gwSchedule[_currentRun.idx + 1].game,
                category: gwSchedule[_currentRun.idx + 1].category,
                estimate: gwSchedule[_currentRun.idx + 1].estimate,
                console: gwSchedule[_currentRun.idx + 1].console,
                notes: gwSchedule[_currentRun.idx + 1].notes
            }
            const nextSchedulePlayers = gwSchedule[_currentRun.idx + 1].players;
            const _nextPlayers = assignSchedulePlayers(nextRunValue.players, nextSchedulePlayers);

            _nextRun.players = _nextPlayers;
            console.log(_nextRun);
            nextRun.value = _nextRun;
        } else {
            _nextRun = nextRunValue;
        }
        riot.mount('gw-schedule', { current: _currentRun, next: _nextRun, schedules: gwSchedule });
        riot.mount('gw-rundown', {schedule: gwSchedule, current: _currentRun});
    });
    nodecg.readReplicant('stopwatch', stopwachValue => {
        const time = stopwachValue.time.formatted;
        riot.mount('gw-timekeeper', { players: _currentRun.players, time: time });
    })
});

/* 
    Observerイベント
*/

// Schedule
nodeCgObserver.on('schedule-prev', () => {
    // インデックスが最小値だったら何もしない
    if (currentRun.value.idx != 0) {
        nextRun.value = Object.assign(nextRun.value, currentRun.value);
        const _idx = currentRun.value.idx - 1;
        const currentSchedulePlayers = gwSchedule[_idx].players;
        console.log(currentSchedulePlayers);
        const _currentPlayers = assignSchedulePlayers(currentRun.value.players, currentSchedulePlayers);
        currentRun.value = Object.assign(currentRun.value,
            {
                idx: _idx,
                game: gwSchedule[_idx].game,
                category: gwSchedule[_idx].category,
                estimate: gwSchedule[_idx].estimate,
                console: gwSchedule[_idx].console,
                notes: gwSchedule[_idx].notes,
                players: _currentPlayers
            }
        );
    }
});

nodeCgObserver.on('schedule-next', () => {
    // インデックスが最大値だったら何もしない
    if (currentRun.value.idx != (gwSchedule.length - 1)) {
        currentRun.value = Object.assign(currentRun.value, nextRun.value);
        const _idx = nextRun.value.idx + 1;
        // 次のスケジュールがある
        if (_idx < gwSchedule.length) {
            const nextSchedulePlayers = gwSchedule[_idx].players;
            const _nextPlayers = assignSchedulePlayers(nextRun.value.players, nextSchedulePlayers);
            nextRun.value = Object.assign(nextRun.value,
                {
                    idx: _idx,
                    game: gwSchedule[_idx].game,
                    category: gwSchedule[_idx].category,
                    estimate: gwSchedule[_idx].estimate,
                    console: gwSchedule[_idx].console,
                    notes: gwSchedule[_idx].notes,
                    players: _nextPlayers
                }
            );
        } else {
            // 次のスケジュールがない場合
            nextRun.value = Object.assign(nextRun.value, {
                idx: _idx,
                game: '',
                category: '',
                estimate: '',
                console: '',
                notes: '',
                players: assignSchedulePlayers(nextRun.value.players, [])
            })
        }
    }
})

nodeCgObserver.on('take-schedule', scheduleIdx => {
    // 一応範囲チェック
    if (scheduleIdx > -1 && scheduleIdx < gwSchedule.length) {
        const _currentidx = scheduleIdx
        const currentSchedulePlayers = gwSchedule[_currentidx].players;
        const _currentPlayers = assignSchedulePlayers(currentRun.value.players, currentSchedulePlayers);
        currentRun.value = Object.assign(currentRun.value,
            {
                idx: _currentidx,
                game: gwSchedule[_currentidx].game,
                category: gwSchedule[_currentidx].category,
                estimate: gwSchedule[_currentidx].estimate,
                console: gwSchedule[_currentidx].console,
                notes: gwSchedule[_currentidx].notes,
                players: _currentPlayers
            }
        );

        const _nextidx = scheduleIdx + 1;
        // 次のスケジュールがある
        if (_nextidx < gwSchedule.length) {
            const nextSchedulePlayers = gwSchedule[_nextidx].players;
            const _nextPlayers = assignSchedulePlayers(nextRun.value.players, nextSchedulePlayers);
            nextRun.value = Object.assign(nextRun.value,
                {
                    idx: _nextidx,
                    game: gwSchedule[_nextidx].game,
                    category: gwSchedule[_nextidx].category,
                    estimate: gwSchedule[_nextidx].estimate,
                    console: gwSchedule[_nextidx].console,
                    notes: gwSchedule[_nextidx].notes,
                    players: _nextPlayers
                }
            );
        } else {
            // 次のスケジュールがない場合
            nextRun.value = Object.assign(nextRun.value, {
                idx: _nextidx,
                game: '',
                category: '',
                estimate: '',
                console: '',
                notes: '',
                players: assignSchedulePlayers(nextRun.value.players, [])
            })
        }
    }
})

nodeCgObserver.on('edit-current-run', run => {
    currentRun.value = Object.assign(currentRun.value, run);
})

nodeCgObserver.on('edit-next-run', run => {
    nextRun.value = Object.assign(nextRun.value, run);
})

/*
    Replicant on-change
*/
currentRun.on('change', newCurrentRun => {
    nodeCgObserver.trigger('update-current-run', newCurrentRun);
})
nextRun.on('change', newNextRun => {
    nodeCgObserver.trigger('update-next-run', newNextRun);
})
