package remote2.skins.remoteSkins
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Matrix;
	
	/**
	 * 按钮皮肤
	 * @author yinhunfeixue
	 * 
	 */
	public class ButtonSkin extends OneLabelSkin
	{
		protected var _lightColor:uint = 0xffffff;
		protected var _lightAlpha:Number = 1;
		protected var _darkColor:uint = 0xcccccc;
		protected var _drakAlpha:Number = 1;
		protected var _borderColor:uint = 0xADB6B8;
		protected var _corner:Number = 6;
		
		public function ButtonSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight,  Math.PI / 2);
			var g:Graphics = target.graphics;
			
			g.beginFill(themeColor);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, _corner, _corner);
			g.endFill();
			
			g.lineStyle(1, _borderColor, 1);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _drakAlpha], [0, 255], m);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, _corner, _corner);
			g.endFill();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			switch(newState)
			{
				case "disabled":
					_lightColor = 0xcccccc;
					_darkColor = 0xcccccc;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.6;
					break;
				case "down":
					_lightColor = 0xcccccc;
					_darkColor = 0xffffff;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.4;
					break;
				case "over":
					_lightColor = 0xffffff;
					_darkColor = 0xeeeeee;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.8;
					_drakAlpha = 0.6;
					break;
				default:
					_lightColor = 0xffffff;
					_darkColor = 0xcccccc;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.4;
					break;
			}
		}
	}
}