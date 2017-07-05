package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import remote2.components.Label;
	import remote2.components.RichEditableText;
	import remote2.components.Scroller;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-13
	 */	
	public class TextAreaSkin extends RemoteSkin
	{
		public var textDisplay:RichEditableText;
		public var labelPrompt:Label;
		
		private var _scroller:Scroller;
		
		public function TextAreaSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			textDisplay = new RichEditableText();
			textDisplay.fontFamily = defaultFont;
			textDisplay.color = 0x333333;
			textDisplay.paddingTop = 3;
			textDisplay.paddingLeft = 3;
			textDisplay.paddingBottom = 3;
			textDisplay.paddingRight = 3;
			
			
			var scroller:Scroller = new Scroller();
			scroller.left = 0;
			scroller.right = 0;
			scroller.top = 0;
			scroller.bottom = 0;
			scroller.viewport = textDisplay;
			target.addChild(scroller);
			
			labelPrompt = new Label();
			labelPrompt.color = 0x999999;
			labelPrompt.left = 0;
			labelPrompt.verticalCenter = 0;
			target.addChild(labelPrompt);
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight, Math.PI / 2);
			var g:Graphics = target.graphics;
			g.beginFill(themeColor, 0.3);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
			
			g.lineStyle(1, 0xAAB3B5);
			g.beginGradientFill(GradientType.LINEAR, [0xB5B5B5, 0xBCBCBC], [0.15, 0.05], [0, 255], m);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
	}
}