package modules.canvas
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import remote2.components.UIComponent;
	import remote2.events.MoveEvent;
	import remote2.events.ResizeEvent;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class Holder extends UIComponent
	{
		private var _component:UIComponent;
		
		private var _shapeBorder:Shape;
		private var _mouseDownPoint:Point;
		
		public function Holder()
		{
			super();
			autoDrawRepsonse = false;
			
			_shapeBorder = new Shape();
			addChild(_shapeBorder);
		}

		public function updateForComponent():void
		{
			if(_component)
			{
				var g:Graphics = _shapeBorder.graphics;
				g.clear();
				g.lineStyle(1, 0x556633, 0.3);
				g.drawRect(_component.x, _component.y, Math.max(5, _component.width), Math.max(5, _component.height));
				g.endFill();
			}
		}
		
		public function get component():UIComponent
		{
			return _component;
		}
		
		public function set component(value:UIComponent):void
		{
			if(_component != value)
			{
				if(_component)
				{
					_component.removeEventListener(MoveEvent.MOVE, component_moveHandler);
					_component.removeEventListener(ResizeEvent.RESIZE, component_resizeHandler);
					removeChild(_component);
				}
				_component = value;
				if(_component)
				{
					_component.addEventListener(MoveEvent.MOVE, component_moveHandler);
					_component.addEventListener(ResizeEvent.RESIZE, component_resizeHandler);
					addChild(_component);
					setChildIndex(_shapeBorder, numChildren - 1);
				}
				updateForComponent();
			}
		}
		
		protected function component_resizeHandler(event:ResizeEvent):void
		{
			updateForComponent();
		}
		
		protected function component_moveHandler(event:MoveEvent):void
		{
			updateForComponent();
		}
		
	}
}