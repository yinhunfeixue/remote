package remote2.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import remote2.core.IToolTip;
	import remote2.core.IToolTipElement;
	import remote2.core.Injector;
	import remote2.core.RemoteGlobals;
	
	
	/**
	 * 默认的TOOLTIP管理器
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-3
	 */	
	public class ToolTipManager implements IToolTipManager
	{
		private var _currentTarget:IToolTipElement;
		private var _currentTooltip:IToolTip;
		
		public function ToolTipManager()
		{
		}
		/**
		 * @inheritDoc
		 */	
		public function show(target:IToolTipElement, content:String):void
		{
			if(container == null)
				return;
			if(target == null || content == null || content.length == 0)
				return;
			if(_currentTarget == target && _currentTooltip != null)
			{
				_currentTooltip.text = content;
			}
			else
			{
				removeToolTip(_currentTooltip);
				_currentTarget = target;
				_currentTooltip = createToolTipInstance();
				_currentTooltip.text = content;
				container.addChild(_currentTooltip as DisplayObject);
				adjuestPosition();
				
				container.addEventListener(MouseEvent.MOUSE_MOVE, container_mouseMoveHandler);
			}
		}
		/**
		 * @inheritDoc
		 */	
		protected function container_mouseMoveHandler(event:MouseEvent):void
		{
			adjuestPosition();
		}
		
		/**
		 * 校正当前TIP的位置 
		 * 
		 */		
		private function adjuestPosition():void
		{
			if(_currentTooltip == null)
				return;
			var mousePoint:Point = new Point(container.mouseX + 20, container.mouseY + 20);
			if(mousePoint.x < 0)
				mousePoint.x = 0;
			if(mousePoint.x + _currentTooltip.width > container.width)
				mousePoint.x = container.width - _currentTooltip.width;
			if(mousePoint.y < 0)
				mousePoint.y = 0;
			if(mousePoint.y + _currentTooltip.height > container.height)
				mousePoint.y = container.height - _currentTooltip.height;
			
			_currentTooltip.x = mousePoint.x;
			_currentTooltip.y = mousePoint.y;
		}
		
		private function removeToolTip(toolTip:IToolTip):void
		{
			if(toolTip)
			{
				if(toolTip == _currentTooltip)
					_currentTooltip = null;
				if(container)
				{
					container.removeEventListener(MouseEvent.MOUSE_MOVE, container_mouseMoveHandler);
					if(container.contains(toolTip as DisplayObject))
						container.removeChild(toolTip as DisplayObject);
				}
			}
		}
		
		public function hide(target:IToolTipElement):void
		{
			if(_currentTarget == target)
			{
				removeToolTip(_currentTooltip);
				_currentTarget = null;
			}
		}
		
		public function get currentTarget():IToolTipElement
		{
			return _currentTarget;
		}
		
		private function createToolTipInstance():IToolTip
		{
			return  Injector.createInstance(RemoteGlobals.KEY_TOOLTIP);
		}
		
		private function get container():DisplayObjectContainer
		{
			return RemoteGlobals.toolTipLayer;
		}
	}
}