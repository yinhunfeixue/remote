package remote2.skins.remoteSkins
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.geom.Rectangle;
	
	import flashx.textLayout.elements.BreakElement;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class TitleWindowCloseButtonSkin extends TitleWindowControlButtonSkin
	{
		private var _lineColor:uint;
		public function TitleWindowCloseButtonSkin()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "over":
					_lineColor = 0x869B8A;
					break;
				case "down":
					_lineColor = 0x8A8A8A;
					break;
				default:
					_lineColor = 0x8A8A8A;
					break;
			}
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var padding:Number = 4;
			var rect:Rectangle = new Rectangle(padding, _startY + padding, unscaleWidth - padding * 2, unscaleHeight - padding * 2);
			
			var g:Graphics = target.graphics;
			g.lineStyle(2, _lineColor, 1, false, LineScaleMode.NORMAL, CapsStyle.SQUARE);
			g.moveTo(rect.x, rect.y);
			g.lineTo(rect.right, rect.bottom);
			
			g.moveTo(rect.right, rect.y);
			g.lineTo(rect.x, rect.bottom);
		}
		
	}
}