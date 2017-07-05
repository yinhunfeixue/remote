package remote2.events
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-13
	 * */
	internal class EventObject
	{
		private var _target:IEventDispatcher;
		
		private var _type:String;
		
		private var _listener:Function;
		
		private var _useCapture:Boolean;
		
		private var _priority:int;
		
		private var _useWeakReference:Boolean;
		
		public function EventObject(target:IEventDispatcher, type:String, listener:Function, useCature:Boolean = false, priority:int = 0, useWeakReference:Boolean = false)
		{
			_target = target;
			_type = type;
			_listener = listener;
			_useCapture = useCature;
			_priority = priority;
			_useWeakReference = useWeakReference;
		}
		
		/**
		 * 启用监听 
		 * 
		 */		
		public function open():void
		{
			if(_target && _type && _listener != null)
			{
				_target.addEventListener(_type, _listener, _useCapture, _priority, _useWeakReference);
			}
		}
		
		/**
		 * 关闭监听 
		 * 
		 */		
		public function close():void
		{
			if(_target && _type && _listener != null)
			{
				_target.removeEventListener(_type, _listener, _useCapture);
			}
		}
		
		/**
		 * 对比是否等价 
		 * @param obj 对比的对象
		 * @return 
		 * 
		 */		
		public function equal(obj:EventObject):Boolean
		{
			if(obj == null)
				return false;
			return _target == obj.target && _listener == obj.listener && _type == obj.type && _useCapture == obj.useCapture;
		}
		
		/**
		 * 通过对比各项参数，判断是否等价 
		 * @param target
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @return 
		 * 
		 */		
		public function equal2(target:IEventDispatcher, type:String, listener:Function, useCapture:Boolean = false):Boolean
		{
			return _target == target && _type == type && _listener == listener && _useCapture == useCapture;
		}

		/**
		 * 监听对象 
		 */
		public function get target():IEventDispatcher
		{
			return _target;
		}

		/**
		 * 事件类型 
		 */
		public function get type():String
		{
			return _type;
		}

		/**
		 * 事件处理方法 
		 */
		public function get listener():Function
		{
			return _listener;
		}

		/**
		 * 是否在冒泡阶段监听 
		 */
		public function get useCapture():Boolean
		{
			return _useCapture;
		}

		/**
		 * 优先级 
		 */
		public function get priority():int
		{
			return _priority;
		}

		/**
		 * 是否弱监听 
		 */
		public function get useWeakReference():Boolean
		{
			return _useWeakReference;
		}


	}
}