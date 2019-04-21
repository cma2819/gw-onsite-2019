'use strict'

const stopwatch = nodecg.Replicant('stopwatch');

/*
    タイマー開始
*/
nodeCgObserver.on('start-timer', () => {
    console.log('timekeeper: start');
    nodecg.sendMessage('startTimer');
});

/*
    タイマー停止
*/
nodeCgObserver.on('stop-timer', () => {
    console.log('timekeeper: stop');
    nodecg.sendMessage('stopTimer');
})

/*
    タイマーリセット
*/
nodeCgObserver.on('reset-timer', () => {
    console.log('timekeeper: reset');
    nodecg.sendMessage('resetTimer');
})

/*
    タイマー更新
*/
nodeCgObserver.on('edit-master-time', (index, time) => {
    console.log('timekeeper: edit['+ index + '] -> ' + time);
    nodecg.sendMessage('editTime', {index: index, newTime: time});
})

/*
    タイマープレビュー
*/
stopwatch.on('change', (newVal) => {
    const formatted_time = newVal.time.formatted;
    nodeCgObserver.trigger('time-changed', formatted_time);
})