package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * 单选按钮皮肤 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RadioButtonSkin extends OneLabelSkin
	{
		private var _selected:Boolean;
		
		private var _borderColor:uint = 0x8B9194;
		private var _bgColor:uint = 0xFFFDE8;
		private var _lightColor:uint = 0xffffff;
		private var _lightAlpha:Number = 0.6;
		private var _darkColor:uint = 0xcccccc;
		private var _darkAlpha:Number = 0.4;
		
		private var _r:Number = 7;
		
		public function RadioButtonSkin()
		{
			super();
		}
		
		override protected function createLabel():void
		{
			super.createLabel();
			labelDisplay.left = 18;
			labelDisplay.right = 0;
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			var center:Point = new Point(_r, unscaleHeight / 2);
			var m:Matrix = new Matrix();
			m.createGradientBox(_r * 2, _r * 2,  Math.PI);
			
			g.beginFill(_bgColor);
			g.drawCircle(center.x ,center.y, _r);
			g.endFill();
			
			
			g.lineStyle(1, _borderColor);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _darkAlpha], [0, 255], m);
			g.drawCircle(center.x, center.y, _r);
			g.endFill();
			
			if(_selected)
			{
				g.lineStyle(0, 0, 0);
				g.beginGradientFill(GradientType.LINEAR, [0, 0], [0.4, 1], [0, 255], m);
				g.drawCircle(center.x, center.y, 2);
				g.endFill();
			}
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			_selected = target.currentState.indexOf("AndSelected") >= 0;
		}
	}
}