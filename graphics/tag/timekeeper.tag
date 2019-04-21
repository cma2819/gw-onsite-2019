<timekeeper>
    <table>
        <tr>
            <td class="time {state}"><span>{time}</span></td>
        </tr>
        <tr>
            <td class="category">{category}</td>
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
            font-size: 10vh;
            border-bottom: 2px var(--theme-color) solid;
            text-align: left;
        }

        .category {
            text-align: right;
        }

        .not_started {
            color: #aaaaaa;
        }

        .running {
            color: #ffffff;
        }

        .paused,
        .finised {
            color: #ffff22;
        }
    </style>

    <script>
        this.time = opts.time;
        this.state = opts.state;
        this.category = opts.category;

        // 形式はhh:MM:SS
        observer.on('time-changed', data => {
            this.update({ time: data.time, state: data.state });
        })

        observer.on('update-category', category => {
            this.update({category: category});
        })

    </script>
</timekeeper>
