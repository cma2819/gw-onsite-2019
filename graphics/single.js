'use strict';
// Configuration
const gwSchedule = nodecg.bundleConfig.schedule;

// Replicant
const currentRun = nodecg.Replicant('current-run');
const stopwatch = nodecg.Replicant('stopwatch');

// 初期表示
const observer = riot.observable();
riot.mount('video-view');
riot.mount('title-text');
riot.mount('time-text');
nodecg.readReplicant('current-run', currentRunValue => {
    riot.mount('run-info', { run: currentRunValue });
    nodecg.readReplicant('stopwatch', stopwatch => {
        const formatted_time = stopwatch.time.formatted.split('.')[0];
        const state = stopwatch.state;
        riot.mount('timekeeper', { time: formatted_time, state: state, estimate: currentRunValue.estimate });
    });

    const infos = [];
    for (var key in currentRunValue.players) {
        if (currentRunValue.players[key].name) {
            infos.push(currentRunValue.players[key]);
        }
    }
    riot.mount('player-info', { infos: infos });

    riot.mount('setup', {itemlist: gwSchedule, current: currentRunValue});
});

// Run情報の更新時
currentRun.on('change', newVal => {
    observer.trigger('update-run-info', newVal);
    const infos = [];
    for (var key in newVal.players) {
        if (newVal.players[key].name) {
            infos.push(newVal.players[key]);
        }
    }
    observer.trigger('update:player-info', infos);
    observer.trigger('update-current', newVal);
})

// タイム変更時
stopwatch.on('change', newVal => {
    const formatted_time = newVal.time.formatted.split('.')[0];
    const state = newVal.state;
    observer.trigger('time-changed', { time: formatted_time, state: state });
})


function getYmdFromDate(date) {
    const year = paddingBy('0', date.getFullYear(), 4);
    const month = paddingBy('0', date.getMonth() + 1, 2);
    const day = paddingBy('0', date.getDate(), 2);
    return year + '/' + month + '/' + day;
}

function getTimeFromDate(date) {
    const hour = paddingBy('0', date.getHours(), 2);
    const minute = paddingBy('0', date.getMinutes(), 2);
    return hour + ':' + minute;
}
function paddingBy(str, src, num) {
    let base = '';
    for (var i = 0; i < num; i++) {
        base += str;
    }
    return (base + src).slice(num * -1);
}