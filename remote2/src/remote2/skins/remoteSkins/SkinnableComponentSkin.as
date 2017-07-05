package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	/**
	 * 矩形皮肤 
	 * @author yinhunfeixue
	 * 
	 */	
	public class SkinnableComponentSkin extends RemoteSkin
	{
		private var _bgColor:uint = 0xffffff;
		
		public function SkinnableComponentSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.lineStyle(1);
			g.beginFill(_bgColor, 1);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			if(newState == "normal")
				_bgColor = 0xffffff;
			else if(newState == "disabled")
				_bgColor = 0xEEEEEE;
		}
	}
}