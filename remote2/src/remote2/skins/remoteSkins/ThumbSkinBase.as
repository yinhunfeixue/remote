package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	internal class ThumbSkinBase extends RemoteSkin
	{
		protected var bgColor:uint = 0xB5B5B5;
		protected var bgAlpha:Number = 0.55;
		protected var lineColor:uint = 0xB0B0B0;
		
		public function ThumbSkinBase()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "over":
					bgColor = 0x000000;
					bgAlpha = 0.2;
					break;
				default:
					bgColor = 0xB5B5B5;
					bgAlpha = 0.55;
					break;
			}
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.beginFill(bgColor, bgAlpha);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
	}
}