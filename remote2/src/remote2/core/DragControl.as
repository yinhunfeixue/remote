package remote2.core
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import remote2.events.DragEvent;

	/**
	 * 拖动控制器
	 * 集成拖动实现
	 *
	 * @author xujunjie
	 * @date 2013-5-28 下午10:35:51
	 * 
	 */	
	public class DragControl
	{
		private var target:InteractiveObject;
		
		private var _mouseDownPoint:Point;
		
		/**
		 * 实例化 
		 * @param target 目标对象
		 * 
		 */		
		public function DragControl(target:InteractiveObject)
		{
			this.target = target;
		}
		
		/**
		 * 允许拖动，当target需要销毁前，一定要调用refuseDrag方法。
		 * 
		 */		
		public function allowDrag():void
		{
			if(target)
			{
				target.addEventListener(MouseEvent.MOUSE_DOWN, target_mouseDownHandler);
			}
		}
		
		protected function target_mouseDownHandler(event:MouseEvent):void
		{
			_mouseDownPoint = new Point(event.localX, event.localY);
			_mouseDownPoint = (event.target as DisplayObject).localToGlobal(_mouseDownPoint);
			target.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			target.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			removeDragStartListener();
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void
		{
			if(_mouseDownPoint == null)
				return;
			var currentPoint:Point = new Point(event.localX, event.localY);
			currentPoint = (event.target as DisplayObject).localToGlobal(currentPoint);
			var minLen:Number = 5;
			trace(currentPoint.x - _mouseDownPoint.x);
			if(Math.abs(currentPoint.x - _mouseDownPoint.x) > minLen ||
				Math.abs(currentPoint.y - _mouseDownPoint.y) > minLen)
			{
				var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_START);
				dragEvent.dragInitiator = target;
				
				var localMouseDownPoint:Point = target.globalToLocal(_mouseDownPoint);
				
				dragEvent.localX = localMouseDownPoint.x;
				dragEvent.localY = localMouseDownPoint.y;
				dragEvent.buttonDown = true;
				
				target.dispatchEvent(dragEvent);
				removeDragStartListener();
			}

		}
		
		private function removeDragStartListener():void
		{
			if(target && target.stage)
			{
				target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				target.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				_mouseDownPoint = null;
			}
		}
		
		/**
		 * 停止手动操作 
		 * 
		 */		
		public function refuseDrag():void
		{
			removeDragStartListener();
			target.removeEventListener(MouseEvent.MOUSE_DOWN, target_mouseDownHandler);
		}
	}
}