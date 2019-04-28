<gw-countdown>
    <style>
        #gw-countdown {
            padding: 15px;
        }
    </style>
    <countdown
        id="gw-countdown"
        time="{time}"
        running="{running}"></countdown>
    <script>
        this.time = opts.time;
        this.running = opts.running;
        
        this.on('mount', () => {
            this.tags['countdown'].on('countdown-start', time => {
                nodeCgObserver.trigger('countdown-start', time);
            });
            this.tags['countdown'].on('countdown-stop', () => {
                nodeCgObserver.trigger('countdown-stop');
            });
        })

        nodeCgObserver.on('update-countdown-time', time => {
            this.tags['countdown'].trigger('update-time', time);
        });
        nodeCgObserver.on('update-countdown-running', running => {
            this.tags['countdown'].trigger('update-running', running);
        })
    </script>
</gw-countdown>