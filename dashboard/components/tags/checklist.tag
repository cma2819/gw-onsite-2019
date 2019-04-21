<checklist>

    <custom-style>
        <style include="iron-flex iron-flex-alignment">
            paper-checkbox {
                border-width: 1px;
                border-radius: 3px;
            }

            .header {
                color: black;
                font-size: 13px;
                font-weight: bold;
                border-bottom: 1px solid black;
                margin-bottom: 5px;
                user-select: none;
            }

			#columns > * {
				@apply --layout-flex;
				margin: 7px 0;
			}

			#columns > :first-child {
				margin-top: 0;
			}

			#columns > :last-child {
				margin-bottom: 0;
            }
            
            section {
                @apply --layout-vertical;
            }
        </style>
    </custom-style>

    <div id="columns" class="layout vertical">
        <section class="layout vertical" each="{col, groupIdx in content}">
            <div class="header">{col.label}</div>
            <div class="group">
                <paper-checkbox each="{check, checkIdx in col.checks}" group="{groupIdx}" idx="{checkIdx}" checked="{checklist[groupIdx][checkIdx]}"
                    onchange="{changeCheck}">{check}</paper-checkbox>
            </div>
        </section>
    </div>

    <script>
        this.content = opts.content;
        // チェックリスト初期化
        this.checklist = [];
        for (var i = 0; i < this.content.length; i++) {
            this.checklist[i] = [];
            for (var j = 0; j < this.content[i].checks.length; j++) {
                this.checklist[i][j] = false;
            }
        }

        this.on('reset-checklist', () => {
            for (var i = 0; i < this.checklist.length; i++) {
                for (var j = 0; j < this.checklist[i].length; j++) {
                    this.checklist[i][j] = false;
                }
            }
            console.log(this.checklist);
            this.update();
        })
        changeCheck(e) {
            const i = parseInt(e.currentTarget.attributes.group.value);
            const j = parseInt(e.currentTarget.attributes.idx.value);
            this.checklist[i][j] = e.currentTarget.checked;
            this.trigger('change-checklist', isAllCheck(this.checklist));
        }

        function isAllCheck(list) {
            for (var i = 0; i < list.length; i++) {
                for (var j = 0; j < list[i].length; j++) {
                    if (!list[i][j]) {
                        return false;
                    }
                }
            }
            return true;
        }
    </script>

</checklist>