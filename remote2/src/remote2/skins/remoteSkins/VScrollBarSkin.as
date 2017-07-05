package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import remote2.components.Button;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class VScrollBarSkin extends VSliderSKin
	{
		public var decrementButton:Button;
		public var incrementButton:Button;
		
		private var _lightColor:uint = 0xBCBCBC;
		private var _darkColor:uint = 0xB5B5B5;
		private var _lightAlpha:Number = 0.05;
		private var _darkAlpha:Number = 0.15;
		private var _borderColor:uint = 0x1B1B1B;
		private var _borderAlpha:Number = 0.3;
		
		public function VScrollBarSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			track.percentHeight = NaN;
			track.top = 15;
			track.bottom = 15;
			track.skinClass = null;
			
			thumb.height = 20;
			thumb.skinClass = VThumbSkin;
			
			decrementButton = new Button();
			decrementButton.top = 0;
			decrementButton.height = 15;
			decrementButton.percentWidth = 100;
			decrementButton.skinClass = VDecrementButtonSkin;
			target.addChild(decrementButton);
			
			incrementButton = new Button();
			incrementButton.bottom = 0;
			incrementButton.height = 15;
			incrementButton.percentWidth = 100;
			incrementButton.skinClass = VIncrementButtonSkin;
			target.addChild(incrementButton);
		}
		
		override public function uninstall():void
		{
			target.removeChild(decrementButton);
			target.removeChild(incrementButton);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.beginFill(themeColor, 0.4);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
			
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight);
			
			g.lineStyle(1, _borderColor, _borderAlpha);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _darkAlpha], [0, 255], m);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
	}
}