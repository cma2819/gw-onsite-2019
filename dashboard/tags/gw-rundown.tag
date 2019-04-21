<gw-rundown>
    
    <div class="title">今後の予定</div>
    <rundown schedule="{schedule}" current="{current}"></rundown>
    <script>
        this.schedule = opts.schedule;
        this.current = opts.current;

        nodeCgObserver.on('update-current-run', newCurrentRun => {
            this.tags.rundown.trigger('update-current', newCurrentRun);
        })
    </script>
</gw-rundown>