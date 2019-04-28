<countdown>
    <style>
        :scope {
            display: block;
            text-align: center;
            padding: 0.5em;
            background-color: #ffffff;
            box-shadow: 1vw 1vh 1vw;
            border-radius: 0.25vh;
        }
    </style>
    <div>{minutes}:{seconds}</div>
    <script>
        this.time = opts.time;
        this.minutes = ('00' + this.time.minutes).slice(-2);
        this.seconds = ('00' + this.time.seconds).slice(-2);

        observer.on('update-countdown-time', time => {
            this.time = time;
            this.minutes = ('00' + time.minutes).slice(-2);
            this.seconds = ('00' + time.seconds).slice(-2);
            this.update();
        });
    </script>
</countdown>