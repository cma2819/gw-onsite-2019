// スケジュールからReplicantに設定
function assignSchedulePlayers(repPlayers, schePlayers) {
    const players = {
        player1: {},
        player2: {},
        player3: {},
        player4: {}
    };
    const MAX_PLAYERS = 4;
    for (var i = 0; i < MAX_PLAYERS; i++) {
        const key = 'player' + (i + 1);
        if (schePlayers.length > i) {
            players[key] = Object.assign({}, players[key], repPlayers[key], schePlayers[i], {
                time: '', state: 'running'
            });
        } else {
            players[key] = Object.assign({}, players[key], repPlayers[key], {
                name: '', role: 'runner', twitter: '', twitch: '', time: '', state: 'running'
            });
        }
    }
    return players;
}
