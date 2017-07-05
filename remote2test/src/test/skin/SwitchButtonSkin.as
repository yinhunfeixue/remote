package test.skin
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import flashx.textLayout.elements.BreakElement;
	
	import remote2.skins.remoteSkins.RemoteSkin;
	
	public class SwitchButtonSkin extends RemoteSkin
	{
		private var _backgroundColors:Array = [0x006DB6, 0x0487CB, 0x0096DE, 0x0EB7FF];
		private var _circleColor:uint = 0xffffff;
		private var _selected:Boolean;
		
		public function SwitchButtonSkin()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "upAndSelected":
				case "overAndSelected":
				case "downAndSelected":
				case "disabledAndSelected":
					_selected = true;
					_backgroundColors = [0x006DB6, 0x0487CB, 0x0096DE, 0x0EB7FF];
					break;
				default:
					_selected = false;
					_backgroundColors = [0x555555, 0x929292, 0x999999, 0xCCCCCC];
					break;
			}
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight, Math.PI / 2);
			var g:Graphics = target.graphics;
			g.lineStyle(1);
			g.beginGradientFill(GradientType.LINEAR, _backgroundColors, [1, 1, 1, 1], [0, 125, 140, 255], m);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, 10, 10);
			g.endFill();
			
			var r:Number = 6;
			var center:Point = new Point(_selected?unscaleWidth - r:r, unscaleHeight / 2);
			var m2:Matrix = new Matrix();
			m2.createGradientBox(r * 2, r * 2, 0, center.x - r, center.y - r);
			g.beginGradientFill(GradientType.RADIAL, [0xFFffff, 0xdddddd, 0xffffff], [1, 1, 1], [0, 200, 255], m2);
			g.drawCircle(center.x, center.y, r);
			g.endFill();
			
		}
		
	}
}