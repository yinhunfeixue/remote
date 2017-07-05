package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	import remote2.components.RichText;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-3
	 */	
	public class ToolTipSkin extends RemoteSkin
	{
		
		public var textDisplay:RichText;
		
		public function ToolTipSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			textDisplay = new RichText();
			textDisplay.fontFamily = defaultFont;
			textDisplay.left = 5;
			textDisplay.right = 5;
			textDisplay.top = 5;
			textDisplay.bottom = 5;
			textDisplay.color = 0xffffff;
			target.addChild(textDisplay);
		}
		
		override public function uninstall():void
		{
			target.removeChild(textDisplay);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.beginFill(0x666666, 0.7);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, 5, 5);
		}
	}
}