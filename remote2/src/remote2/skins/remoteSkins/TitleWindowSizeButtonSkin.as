package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class TitleWindowSizeButtonSkin extends TitleWindowControlButtonSkin
	{
		private var _selected:Boolean;
		
		public function TitleWindowSizeButtonSkin()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			_selected = newState.indexOf("AndSelected") >= 0;
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var padding:Number = 4;
			var rect:Rectangle = new Rectangle(padding, padding + _startY, unscaleWidth - padding * 2, unscaleHeight - padding * 2);
			
			var g:Graphics = target.graphics;
			g.lineStyle(2, 0x8A8A8A);
			if(_selected)
			{
				g.drawRect(rect.x, rect.y, rect.width, rect.height);
				g.moveTo(rect.x, rect.y + 1);
				g.lineTo(rect.right, rect.y + 1);
			}
			else
			{
				g.moveTo(rect.x, rect.y + rect.height / 2);
				g.lineTo(rect.right, rect.y + rect.height / 2);
			}
		}
		
	}
}