package remote2.events
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 *  事件管理
	 * <br/>
	 * 通常，如果多个对象需要同移除事件监听，可使用此类来注册事件监听，最后调用 unmapAll方法全部移除
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-13
	 * */
	public class EventMap
	{
		/**
		 * 存放所有事件对象的字典，以对象为键 
		 */		
		private var _targetDic:Dictionary;
		
		public function EventMap()
		{
		}

		/**
		 * 注册事件监听 
		 * @param target 事件对象
		 * @param type 事件的类型
		 * @param listener 处理事件的侦听器函数。此函数必须接受事件对象作为其唯一的参数，并且不能返回任何结果
		 * @param useCapture 确定侦听器是运行于捕获阶段还是运行于目标和冒泡阶段。如果将 useCapture 设置为 true，则侦听器只在捕获阶段处理事件，而不在目标或冒泡阶段处理事件。如果 useCapture 为 false，则侦听器只在目标或冒泡阶段处理事件。要在所有三个阶段都侦听事件，请调用两次 addEventListener()，一次将 useCapture 设置为 true，第二次再将 useCapture 设置为 false。
		 * @param priority 事件侦听器的优先级。优先级由一个 32 位整数指定。数字越大，优先级越高。优先级为 n 的所有侦听器会在优先级为 n-1 的侦听器之前处理。如果两个或更多个侦听器共享相同的优先级，则按照它们的添加顺序进行处理。默认优先级为 0。
		 * @param useWeakReference 确定对侦听器的引用是强引用，还是弱引用。强引用（默认值）可防止您的侦听器被当作垃圾回收。弱引用则没有此作用。
		 * 
		 */		
		public function mapEvent(target:IEventDispatcher, type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if(_targetDic == null)
				_targetDic = new Dictionary();
			
			if(_targetDic[target] == null)
				_targetDic[target] = new Vector.<EventObject>();
			
			if(!contains(target, type, listener, useCapture))
			{
				var item:EventObject = new EventObject(target, type, listener, useCapture, priority, useWeakReference);
				item.open();
				getListenerVector(target).push(item);
			}
		}

		/**
		 * 解除事件监听
		 * @param target 事件对象
		 * @param type 事件的类型。
		 * @param listener 删除的侦听器对象。
		 * @param useCapture 指出是为捕获阶段还是为目标和冒泡阶段注册了侦听器。如果为捕获阶段以及目标和冒泡阶段注册了侦听器，则需要对 removeEventListener() 进行两次调用才能将这两个侦听器删除：一次调用将 useCapture 设置为 true，另一次调用将 useCapture 设置为 false。
		 * 
		 */		
		public function unmapEvent(target:IEventDispatcher, type:String, listener:Function, useCapture:Boolean = false):void
		{
			var index:int = getIndex(target, type, listener, useCapture);
			if(index >= 0)
			{
				var item:EventObject = _targetDic[target][index];
				item.close();
				getListenerVector(target).splice(index, 1);
			}
		}
		
		/**
		 * 解除所有的事件监听 
		 * 
		 */		
		public function unmapAll():void
		{
			for(var target:* in _targetDic)
			{
				for each (var item:EventObject in _targetDic[target]) 
				{
					item.close();
				}
			}
			_targetDic = null;
		}
		
		private function getListenerVector(target:IEventDispatcher):Vector.<EventObject>
		{
			if(_targetDic && _targetDic[target])
				return _targetDic[target];
			return null;
		}
		
		private function contains(target:IEventDispatcher, type:String, listener:Function, useCapture:Boolean = false):Boolean
		{
			return getIndex(target, type, listener, useCapture) >= 0;
		}
		
		private function getIndex(target:IEventDispatcher, type:String, listener:Function, useCapture:Boolean = false):int
		{
			var vector:Vector.<EventObject> = getListenerVector(target);
			if(vector)
			{
				for (var i:int = 0; i < vector.length; i++) 
				{
					if(vector[i] != null && vector[i].equal2(target, type, listener, useCapture))
						return i;
				}
			}
			return -1;
		}
	}
}