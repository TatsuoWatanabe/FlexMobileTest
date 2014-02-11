package
{
	import flash.display.Graphics;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import spark.components.IconItemRenderer;
	import spark.components.List;
	import spark.core.NavigationUnit;
	import spark.effects.Animate;
	import spark.effects.animation.*;	
	
	public class ChatItemRenderer extends IconItemRenderer {
		public var listMaxLength: int = 10;
		public var duration: Number = 150;
		public var animation: Boolean = true;
		
		/**
		 * コンストラクタ
		 */
		public function ChatItemRenderer() {
			super();
		}
		
		/**
		 * @private
		 * データの変更に応答するには、この setter をオーバーライドします
		 */
		public override function set data(value:Object):void {
			super.data = value;
			const list: List = this.owner as List;
			list.dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, function(e: CollectionEvent): void {
				if (e.kind !== CollectionEventKind.ADD) { return; }
				
				while (list.dataProvider.length > listMaxLength) list.dataProvider.removeItemAt(0);
				list.validateNow();
				
				if (animation) {
					const animate: Animate = new Animate(list.dataGroup);
					animate.duration = duration;
					animate.motionPaths = Vector.<MotionPath>([new SimpleMotionPath(
						"verticalScrollPosition", // property
						null, // valueFrom
						list.layout.verticalScrollPosition + list.layout.getVerticalScrollPositionDelta(NavigationUnit.END) // valueTo
					)]);
					animate.play();
				} else {
					list.layout.verticalScrollPosition += list.layout.getVerticalScrollPositionDelta(NavigationUnit.END);
				}
			});
		}
		
		/**
		 * @private
		 * アイテムレンダラーの子を作成するには、このメソッドをオーバーライドします
		 */
		protected override function createChildren():void {
			super.createChildren();
			if(labelDisplay != null) {
				labelDisplay.multiline  = true;
				labelDisplay.wordWrap   = true;
				labelDisplay.selectable = true;
			}
		}
		
		/**
		 * @private
		 * アイテムレンダラー自身によるサイズ設定方法を変更するには、
		 * このメソッドをオーバーライドします。パフォーマンスに影響するため、
		 * 必要がない場合は super.measure() を呼び出さないでください。
		 */
/*		protected override function measure():void {
			super.measure();
		}*/
		
		/**
		 * @private
		 * アイテムレンダラーの背景の描画方法を変更するには、このメソッドを
		 * オーバーライドします。パフォーマンスに影響するため、必要がない場合は
		 * super.drawBackground() を呼び出さないでください。
		 */
/*		protected override function drawBackground(unscaledWidth:Number,
												   unscaledHeight:Number):void {
			var g:Graphics = graphics;
			var backgroundColor :uint;
			if(down) {
				backgroundColor = 0x999999;
			}
			else if(showsCaret) {
				backgroundColor = 0xcc3333;
			}
			else {
				backgroundColor = 0xcccccc;
			}
			
			g.clear();
			g.beginFill(0x666666);
			g.drawRoundRectComplex(5, 5, unscaledWidth - 10,
				unscaledHeight - 10, 10, 10, 10, 10);
			g.endFill();
			
			g.beginFill(backgroundColor);
			g.drawRoundRectComplex(6, 6, unscaledWidth - 12,
				unscaledHeight - 12, 9, 9, 9, 9);
			//g.endFill();
		}*/
		/**
		 * @private
		 * このアイテムレンダラーの背景の描画方法を変更するには、このメソッドを
		 * オーバーライドします。パフォーマンスに影響するため、必要がない場合は
		 * super.layoutContents() を呼び出さないでください。
		 */
/*		protected override function layoutContents(unscaledWidth:Number,
												   unscaledHeight:Number):void {
			super.layoutContents(unscaledWidth, unscaledHeight);
		}*/
	}
}