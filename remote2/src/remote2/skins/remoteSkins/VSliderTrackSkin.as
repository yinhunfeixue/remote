package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;

	public class VSliderTrackSkin extends RemoteSkin
	{
		private var _lightColor:uint = 0xcccccc;
		private var _lightAlpha:Number = 0.4;
		private var _darkColor:uint = 0xffffff;
		private var _drakAlpha:Number = 0.6;
		private var _bgColor:uint = 0xFFFDE8;
		private var _borderColor:uint = 0xADB6B8;
		
		public function VSliderTrackSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight);
			
			var g:Graphics = target.graphics;
			
			g.beginFill(_bgColor);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
			
			g.lineStyle(1, _borderColor, 1);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _drakAlpha], [0, 255], m);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
	}
}