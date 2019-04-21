<time-text>
    <style>
        :scope {
            display: block;
        }
        span.show {
            opacity: 0;
        }
    </style>
    <span>{hour}<span class="{toggleClass}">:</span>{minute}</span>
    <script>
        this.hour = '00';
        this.minute = '00';
        this.toggleClass = 'show';
        setInterval(() => { this.reloadView() }, 500);
        reloadView() {
            const now = new Date(Date.now());
            this.hour = ('00' + now.getHours()).slice(-2);
            this.minute = ('00' + now.getMinutes()).slice(-2);
            if (this.toggleClass == '') {
                this.toggleClass = 'show';
            } else {
                this.toggleClass = '';
            }
            this.update();
        }
    </script>
</time-text>