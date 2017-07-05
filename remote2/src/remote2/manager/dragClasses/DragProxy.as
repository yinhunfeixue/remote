package remote2.manager.dragClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import remote2.components.UIComponent;
	import remote2.core.DragSource;
	import remote2.events.DragEvent;
	import remote2.manager.DragManager;
	
	/**
	 * 拖动代理
	 * 每一个拖动操作，对应一个DragProxy对象
	 * 开发者一般使用不到此类
	 *
	 * @author xujunjie
	 * @date 2013-5-27 下午10:31:38
	 * 
	 */	
	public class DragProxy extends UIComponent
	{
		/**
		 *  @private
		 */
		public var dragInitiator:DisplayObject;
		
		/**
		 *  @private
		 */
		public var dragSource:DragSource;
		
		public var xoffset:Number;
		
		public var yoffset:Number;
		
		private var _dropTarget2:InteractiveObject;
		
		private var _hovedEvent:MouseEvent;
		
		public function DragProxy(dragInitiator:DisplayObject, dragSource:DragSource)
		{
			super();
			this.dragInitiator = dragInitiator;
			this.dragSource = dragSource;
			mouseChildren = false;
			mouseEnabled = false;
			addStageListener();
		}
		
		public function endDrag():void
		{
			removeStageListener();
			dragInitiator = null;
			dropTarget2 = null;
			dragSource = null;
		}
		
		private function addStageListener():void
		{
			var stage:Stage = dragInitiator.stage;
			if(stage)
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_OVER, stage_mouseOverHandler);
				stage.addEventListener(MouseEvent.MOUSE_OUT, stage_mouseOutHandler);
			}
		}
		
		private function removeStageListener():void
		{
			var stage:Stage = dragInitiator.stage;
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				stage.removeEventListener(MouseEvent.MOUSE_OVER, stage_mouseOverHandler);
				stage.removeEventListener(MouseEvent.MOUSE_OUT, stage_mouseOutHandler);
			}
		}
		
		protected function stage_mouseOutHandler(event:MouseEvent):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if(target == null || target == this || contains(target))
				return;
			if(_hovedEvent && _hovedEvent.target == event.target)
			{
				_hovedEvent = null;
			}
			dispatchDrapEvent(DragEvent.DRAG_EXIT, event, target);
		}
		
		protected function stage_mouseOverHandler(event:MouseEvent):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if(target == null || target == this || contains(target))
				return;
			_hovedEvent = event;
			//如果是dropTarget,发出dropOver
			if(isDropTarget(target))
				dispatchDrapEvent(DragEvent.DRAG_OVER, event, target);
			else
				dispatchDrapEvent(DragEvent.DRAG_ENTER, event, target);
		}
		
		private function dispatchDrapEvent(type:String, sourceEvent:MouseEvent, eventTarget:InteractiveObject):void
		{
			//循环父对象，全部发出事件
			var target:InteractiveObject = eventTarget;
			var event:DragEvent = new DragEvent(type, false, false, dragInitiator, dragSource, sourceEvent.ctrlKey, sourceEvent.altKey, sourceEvent.shiftKey);
			event.localX = sourceEvent.localX;
			event.localY = sourceEvent.localY;
			event.relatedObject = sourceEvent.relatedObject;
			while(target != null)
			{
				if(target.hasEventListener(type))
					target.dispatchEvent(event);
				target = target.parent;
			}
		}
		
		private function isDropTarget(object:InteractiveObject):Boolean
		{
			return object == dropTarget2 ||((dropTarget2 is DisplayObjectContainer) && (dropTarget2 as DisplayObjectContainer).contains(object));
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if(target == this || contains(target))
			{
				
			}
			else if(isDropTarget(target))
			{
				dispatchDrapEvent(DragEvent.DRAG_DROP, event, target);
			}
			DragManager.endDrag();
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void
		{		
			x = stage.mouseX + xoffset;
			y = stage.mouseY + yoffset;
			event.updateAfterEvent();
		}
		
		/**
		 * @private 
		 */
		public function get dropTarget2():InteractiveObject
		{
			return _dropTarget2;
		}
		
		/**
		 * @private
		 */
		public function set dropTarget2(value:InteractiveObject):void
		{
			_dropTarget2 = value;
			if(_hovedEvent && isDropTarget(_hovedEvent.target as InteractiveObject))
				dispatchDrapEvent(DragEvent.DRAG_OVER, _hovedEvent, _hovedEvent.target as InteractiveObject);
		}
		
	}
}