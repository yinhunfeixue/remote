package remote2.manager
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import remote2.core.ILayoutElement;
	import remote2.core.IValidateElement;
	import remote2.core.RemoteGlobals;
	import remote2.events.RemoteEvent;
	import remote2.manager.layoutClasses.PriorityQueue;
	
	/**
	 * 布局管理器，用于管理所有控件的延迟测量和布局 
	 * @private
	 * @author yinhunfeixue
	 * 
	 */	
	public class LayoutManager
	{
		private static var _instance:LayoutManager;
		
		public static function get instance():LayoutManager
		{
			if(_instance == null)
				_instance = new LayoutManager();
			return _instance;
		}
		
		private var _stage:Stage;
		private var _invalidateDisplayQueue:PriorityQueue = new PriorityQueue();
		private var _invalidatePropertiesQueue:PriorityQueue = new PriorityQueue();
		private var _invalidateSizeQueue:PriorityQueue = new PriorityQueue();
		private var _updateCompleteQueue:PriorityQueue = new PriorityQueue();
		
		private var _listenersAttached:Boolean = false;
		
		
		public function LayoutManager()
		{
			_stage = RemoteGlobals.stage;
		}
		
		private function attachListeners():void
		{
			if(_stage)
			{
				trace("enterframe:" + getTimer());
				_listenersAttached = true;
				_stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			_stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_listenersAttached = false;
			doPhasedInstantiation();
		}
		
		public function invalidateDisplayList(obj:IValidateElement):void
		{
			if(!_listenersAttached)
				attachListeners();
			_invalidateDisplayQueue.addObject(obj, obj.depth);
			if(obj.updateCompletePendingFlag == false)
				_updateCompleteQueue.addObject(obj, obj.depth);
		}
		
		public function invalidateSize(obj:IValidateElement):void
		{
			if(!_listenersAttached)
				attachListeners();
			_invalidateSizeQueue.addObject(obj, obj.depth);
			if(obj.updateCompletePendingFlag == false)
				_updateCompleteQueue.addObject(obj, obj.depth);
		}
		
		public function invalidateProperties(obj:IValidateElement):void
		{
			if(!_listenersAttached)
				attachListeners();
			_invalidatePropertiesQueue.addObject(obj, obj.depth);
			if(obj.updateCompletePendingFlag == false)
				_updateCompleteQueue.addObject(obj, obj.depth);
		}
		
		private function doPhasedInstantiation():void
		{
			validateProperties();
			validateSize();
			validateDisplayList();
			validateClient();
		}
		
		private function validateClient():void
		{
			var obj:IValidateElement = _updateCompleteQueue.removeLagerest();
			while(obj)
			{
				obj.updateCompletePendingFlag = true;
				if(obj.hasEventListener(RemoteEvent.CREATION_COMPLETE))
					obj.dispatchEvent(new RemoteEvent(RemoteEvent.CREATION_COMPLETE));
				obj = _updateCompleteQueue.removeLagerest();
			}
		}
		
		private function validateDisplayList():void
		{
			var obj:IValidateElement = _invalidateDisplayQueue.removeSmallest();
			while(obj)
			{
				obj.validateDisplayList();
				obj = _invalidateDisplayQueue.removeSmallest();
				
			}
		}
		
		private function validateProperties():void
		{
			var obj:IValidateElement = _invalidatePropertiesQueue.removeLagerest();
			while(obj)
			{
				obj.validateProperties();
				obj = _invalidatePropertiesQueue.removeLagerest();
			}
		}
		
		private function validateSize():void
		{
			var obj:IValidateElement = _invalidateSizeQueue.removeLagerest();
			while(obj)
			{
				obj.validateSize();
				obj = _invalidateSizeQueue.removeLagerest();
			}
		}
	}
}