package modules.canvas
{
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	
	import remote2.components.Group;
	
	
	public class ScaleplateLine extends Group
	{
		private var _direction:int = 0;
		public function ScaleplateLine()
		{
			super();
			buttonMode = true;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var g:Graphics = graphics;
			g.clear();
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			g.beginFill(0, 0);
			g.drawRect(-3, -3, _direction == 0?unscaledWidth:6, _direction == 0?6:unscaledHeight);
			g.endFill();
			g.lineStyle(1, 0x00ffff, 1, false, LineScaleMode.NONE);
			g.moveTo(0, 0);
			g.lineTo(unscaledWidth, unscaledHeight);
		}
		
		private function updateToolTip():void
		{
			if(_direction == 0)
				toolTip = y.toString();
			else
				toolTip = x.toString();
		}

		/**
		 * 方向 0表示水平，其它表示竖直
		 */
		public function get direction():int
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:int):void
		{
			_direction = value;
			updateToolTip();
		}
		
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
			updateToolTip();
		}
		
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
			updateToolTip();
		}

	}
}