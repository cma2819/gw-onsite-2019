'use strict';

const countdownRunning = nodecg.Replicant('countdownRunning');
const countdown = nodecg.Replicant('countdown');

// 初期化
nodecg.readReplicant('countdown', countdownValue => {
    nodecg.readReplicant('countdownRunning', countdownRunningValue => {
        riot.mount('gw-countdown', {time: countdownValue, running: countdownRunningValue});
    })
});

nodeCgObserver.on('countdown-start', time => {
    nodecg.sendMessage('startCountdown', time.formatted);
});
nodeCgObserver.on('countdown-stop', () => {
    nodecg.sendMessage('stopCountdown');
});

countdown.on('change', time => {
    nodeCgObserver.trigger('update-countdown-time', time);
});
countdownRunning.on('change', running => {
    nodeCgObserver.trigger('update-countdown-running', running);
})