<rundown class="layout vertical">
    <style>
		:scope {
			width: 100%;
			height: 100%;
		}

		#currentItems,
		#remainderItems {
			padding: 0 12px;
			overflow-y: scroll;
			margin-right: 10px;
		}

		#currentItems {
			margin-top: 8px;
		}

		#remainderItems {
			min-height: 4em;
			margin-bottom: 8px;
		}

		#divider {
			margin: 8px 12px;
			height: 1px;
			background: black;
			box-sizing: border-box;
		}

		#scrollToFuture {
			@apply --layout-center-center;
			@apply --layout-horizontal;
			height: 30px;
			margin: 0 12px 12px;
			padding: 0;
		}

		#scrollToFuture iron-icon {
			margin-right: 6px;
		}

		#tooltip {
			position: absolute;
			top: 0;
			left: 12px;
			transition: opacity 200ms ease-in-out;
			opacity: 0;
			pointer-events: none;
		}

		#tooltip-content {
			font-size: 14px;
			color: white;
			background: rgba(0, 0, 0, 0.8);
			border-radius: 5px;
			padding: 6px;
		}

		::-webkit-scrollbar {
			width: 6px;
		}

		::-webkit-scrollbar-track {
			-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
			-webkit-border-radius: 10px;
			border-radius: 10px;
		}

		::-webkit-scrollbar-thumb {
			border-radius: 5px;
			background: #757575;
			-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
		}

		::-webkit-scrollbar-thumb:window-inactive {
			background: #b9b9b9;;
		}
    </style>

    <div id="currentItems">
		<rundown-item
			ref="current-item"
			item="{schedule[currentIdx]}"
			current="{true}"
			on-mouseover="_showTooltip"
			on-mouseout="_hideTooltip">
		</rundown-item>
    </div>

    <div id="divider"></div>

    <iron-list id="remainderItems" items="[[remainderItems]]" mutable-data class="layout flex">
		<div class="itemWrapper">
			<rundown-item each="{run, runIdx in this.schedule}"
				if="{runIdx > currentIdx}"
				item="{run}"
				on-mouseover="_showTooltip"
				on-mouseout="_hideTooltip">
			</rundown-item>
		</div>
	</iron-list>
	
	<script>
		this.schedule = opts.schedule;
		this.currentIdx = opts.current.idx;

		this.on('update-current', current => {
			this.currentIdx = current.idx;
			this.refs['current-item'].item = this.schedule[this.currentIdx];
			this.refs['current-item'].trigger('update-item');
			this.update();
		})
	</script>
</rundown>

<rundown-item class="layout horizontal shadow-elevation-2dp">
	<style>
		:scope {
			position: relative;
			padding: 4px 9px;
			margin: 8px 0;
			min-height: 55px;
			box-sizing: border-box;
			font-weight: bold;
			@apply --shadow-elevation-2dp;
		}

		:scope(:first-of-type) {
			margin-top: 4px;
		}

		:scope(:last-of-type) {
			margin-bottom: 4px;
		}

		:scope([item-type="run"]) {
			background-color: #E3E3E3;
		}

		:scope([item-type="adBreak"]) {
			background-color: #D9D3FF;
		}

		:scope([item-type="interview"]) {
			background-color: #EBCFCF;
		}

		:scope([current]) #green {
			display: block !important;
		}

		:scope([current]) {
			padding-left: 14px;
		}

		#green {
			position: absolute;
			top: 0;
			left: 0;
			width: 9px;
			height: 100%;
			background: #5BA664;
		}

		#name {
			font-size: 20px;
		}

		#notesIcon {
			position: relative;
			top: -2px;
			width: 20px;
			height: 20px;
		}

		#topRight,
		#bottomRight,
		#bottomLeft {
			font-size: 14px;
			font-style: italic;
		}

		#topRight,
		#bottomRight {
			margin-left: 36px;
			text-align: right;
		}

		.interviewer {
			font-weight: bold;
			color: #A90000;
		}

		:scope([item-type="interview"]) #topRight {
			display: block;
			max-width: 190px;
		}

		[hidden] {
			display: none !important;
		}
	</style>
		<div id="green" if={current}></div>
		<div id="body" class="layout vertical flex">
			<div id="top" class="line layout horizontal">
				<div id="name" class="layout flex">
					{item.game}
					<iron-icon
						id="notesIcon"
						icon="notification:event-note"
						hidden="[[!_itemHasNotes(item)]]">
					</iron-icon>
				</div>
				<div id="topRight" class="layout vertical end flex-none">{item.category}</div>
			</div>

			<div id="bottom" class="line layout horizontal justified">
				<div id="bottomLeft">{playerText}</div>
				<div id="bottomRight" class="layout end flex-none">{item.console} - {item.estimate}</div>
			</div>
		</div>

		<script>
			this.current = opts.current;
			this.item = opts.item;
			const _text = [];
			this.item.players.forEach(player => {
				_text.push(player.name);
			});
			this.playerText = _text.join('/');

			this.on('update-item', () => {
				const _text = [];
				this.item.players.forEach(player => {
					_text.push(player.name);
				});
				this.playerText = _text.join('/');
			});
		</script>
</rundown-item>