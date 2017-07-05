package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import remote2.components.Label;
	import remote2.components.RichEditableText;
	import remote2.components.RichText;
	
	/**
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-5-11
	 * */
	public class TextInputSkin extends RemoteSkin
	{
		public var textDisplay:RichEditableText;
		public var labelPrompt:Label;
		
		private var _lightColor:uint;
		private var _drakColor:uint;
		
		public function TextInputSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			textDisplay = new RichEditableText();
			textDisplay.fontFamily = defaultFont;
			textDisplay.color = 0x333333;
			textDisplay.horizontalCenter = 0;
			textDisplay.verticalCenter = 0;
			textDisplay.left = 3;
			textDisplay.right = 3;
			textDisplay.top = 3;
			textDisplay.bottom = 3;
			target.addChild(textDisplay);
			
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
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _drakColor], [0.15, 0.05], [0, 255], m);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "disabled":
					_lightColor = 0x666666;
					_drakColor = 0x000000;
					break;
				default:
					_lightColor = 0xB5B5B5;
					_drakColor = 0xBCBCBC;
					break;
			}
		}
	}
}