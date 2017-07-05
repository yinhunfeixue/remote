package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * 多选按钮皮肤 
	 * @author yinhunfeixue
	 * 
	 */	
	public class CheckBoxSkin extends OneLabelSkin
	{
		private var _selected:Boolean;
		
		private var _borderColor:uint = 0x8B9194;
		private var _bgColor:uint = 0xFFFDE8;
		private var _lightColor:uint = 0xffffff;
		private var _lightAlpha:Number = 0.6;
		private var _darkColor:uint = 0xcccccc;
		private var _darkAlpha:Number = 0.4;
		
		private var _iconWidth:Number = 14;
		private var _iconHeight:Number = 14;
		
		public function CheckBoxSkin()
		{
			super();
		}
		
		override protected function createLabel():void
		{
			super.createLabel();
			labelDisplay.right = 0;
			labelDisplay.left = 18;
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var startY:Number = (target.height - _iconHeight) / 2;
			
			var m:Matrix = new Matrix();
			m.createGradientBox(_iconWidth, _iconHeight,  Math.PI / 2);
			
			
			var g:Graphics = target.graphics;
			g.beginFill(_bgColor);
			g.drawRect(0,  startY, _iconWidth, _iconHeight);
			g.endFill();
			
			g.lineStyle(1, _borderColor);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _darkAlpha], [0, 255], m);
			g.drawRect(0,  startY, _iconWidth, _iconHeight);
			g.endFill();
			if(_selected)
			{
				g.lineStyle(2);
				g.moveTo(3, startY + 7);
				g.lineTo(6, startY + _iconHeight - 3);
				g.lineTo(_iconWidth - 3, startY + 3);
			}
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			_selected = target.currentState.indexOf("AndSelected") >= 0;
		}
	}
}