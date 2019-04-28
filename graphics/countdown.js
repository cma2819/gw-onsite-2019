'use strict';

const countdownRunning = nodecg.Replicant('countdownRunning');
const countdown = nodecg.Replicant('countdown');

// 初期化
nodecg.readReplicant('countdown', countdownValue => {
    nodecg.readReplicant('countdownRunning', countdownRunningValue => {
        riot.mount('countdown', {time: countdownValue, running: countdownRunningValue});
    })
});

countdown.on('change', time => {
    observer.trigger('update-countdown-time', time);
});