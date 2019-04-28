<timekeeper>
    <table>
        <tr>
            <td class="time {state}"><span>{time}</span></td>
        </tr>
        <tr>
            <td class="estimate">{estimate}</td>
        </tr>
    </table>
    <style>
        :scope {
            display: block;
        }

        table {
            height: 100%;
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        td {
            width: 50%;
            text-align: center;
            vertical-align: bottom;
            padding: 0 10%;
            margin: 0;
        }

        .time {
            font-weight: bold;
            font-size: 8vh;
            border-bottom: 2px var(--theme-color) solid;
            text-align: left;
        }

        .estimate {
            color: #444444;
            text-align: right;
        }

        .not_started {
            color: #666666;
        }

        .running {
            color: #000000;
        }

        .paused,
        .finised {
            color: #22dd22;
        }
    </style>

    <script>
        this.time = opts.time;
        this.state = opts.state;
        this.estimate = opts.estimate;

        // 形式はhh:MM:SS
        observer.on('time-changed', data => {
            this.update({ time: data.time, state: data.state });
        })

        observer.on('update-run-info', run => {
            this.update({estimate: run.estimate});
        })

    </script>
</timekeeper>
