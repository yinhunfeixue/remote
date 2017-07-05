package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	internal class TitleWindowControlButtonSkin extends RemoteSkin
	{
		private var _borderColor:uint = 0xCCCCCC;
		private var _lightColor:uint = 0xffffff;
		private var _darkColor:uint = 0xcccccc;
		
		private var _borderAlpha:Number;
		private var _lightAlpha:Number;
		private var _darkAlpha:Number;
		
		protected var _startY:Number = 0;
		
		public function TitleWindowControlButtonSkin()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "up":
				case "upAndSelected":
					_borderAlpha = 0;
					_lightAlpha = 0;
					_darkAlpha = 0;
					break;
				default:
					_borderAlpha = 1;
					_lightAlpha = 0.5;
					_darkAlpha = 0.5;
					break;
			}
			switch(newState)
			{
				case "downAndSelected":
				case "down":
					_startY = 1;
					break;
				default:
					_startY = 0;
					break;
			}
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight, Math.PI / 2);
			
			var g:Graphics = target.graphics;
			g.lineStyle(1, _borderColor, _borderAlpha);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _darkAlpha], [0, 255], m);
			g.drawRect(0, _startY, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
	}
}