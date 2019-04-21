<gw-countdown>
    <style>
        #gw-countdown {
            padding: 15px;
        }
    </style>
    <countdown
        id="gw-countdown"
        observer="{riot.observable()}"
        time="{
            {minutes: '10', seconds: '00'}
        }"
        running="{true}"></countdown>
</gw-countdown>