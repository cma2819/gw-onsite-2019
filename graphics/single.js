'use strict';

// Replicant
const run = nodecg.Replicant('run');
const players = nodecg.Replicant('players');
const options = nodecg.Replicant('options', { defaultValue: {} });
const setup = nodecg.Replicant('setup', { defaultValue: {} });
const stopwatch = nodecg.Replicant('stopwatch');

// 初期表示
const observer = riot.observable();
riot.mount('video-view');
riot.mount('time-text');
nodecg.readReplicant('run', run => {
    riot.mount('run-info', { run: run });
    nodecg.readReplicant('stopwatch', stopwatch => {
        const formatted_time = stopwatch.time.formatted.split('.')[0];
        const state = stopwatch.state;
        riot.mount('timekeeper', { time: formatted_time, state: state, category: run.category });
    });
});
nodecg.readReplicant('players', players => {
    const infos = [];
    for (var key in players) {
        if (players[key].name) {
            infos.push(players[key]);
        }
    }
    riot.mount('player-info', { infos: infos });
})

// Run情報の更新時
run.on('change', newVal => {
    observer.trigger('update-run-info', newVal);
    observer.trigger('update-category', newVal.category);
})

// 走者情報の更新時
players.on('change', newVal => {
    const infos = [];
    for (var key in newVal) {
        if (newVal[key].name) {
            infos.push(newVal[key]);
        }
    }
    observer.trigger('update:player-info', infos);
})

// タイム変更時
stopwatch.on('change', newVal => {
    const formatted_time = newVal.time.formatted.split('.')[0];
    const state = newVal.state;
    observer.trigger('time-changed', { time: formatted_time, state: state });
})
