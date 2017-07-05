package remote2.manager.layoutClasses
{
	import flash.utils.Dictionary;

	/**
	 * 有优先级的队列
	 * 数据结构为[优先级] = PriorityBin
	 * 值越大，表示优级越高
	 * 需要注意，优先级并不是等差数列
	 * 
	 * @private
	 * @author xujunjie
	 * 
	 */	
	public class PriorityQueue
	{
		private var _minPriority:int;
		private var _maxPriority:int;
		private var _queue:Dictionary;
		
		public function PriorityQueue()
		{
			_queue = new Dictionary();
			_minPriority = 0;
			_maxPriority = -1;
		}
		
		public function addObject(obj:*, priority:int):void
		{
			if(_minPriority > priority)
				_minPriority = priority;
			if(_maxPriority < priority)
				_maxPriority = priority;
			
			var bin:PriorityBin = _queue[priority];
			if(!bin)
			{
				_queue[priority] = bin = new PriorityBin();
			}
			bin.addObject(obj);
		}
		
		public function removeLagerest():*
		{
			var result:*;
			if(_minPriority <= _maxPriority)
			{
				var bin:PriorityBin = _queue[_maxPriority];
				while(!bin || bin.length == 0)
				{
					_maxPriority--;
					if(_maxPriority < _minPriority)
						return null;
					bin = _queue[_maxPriority];
				}
				result = bin.removeRandom();
			}
			return result;
		}
		
		public function removeSmallest():*
		{
			var result:*;
			if(_minPriority <= _maxPriority)
			{
				var bin:PriorityBin = _queue[_minPriority];
				while(bin == null || bin.length == 0)
				{
					_minPriority++;
					if(_minPriority > _maxPriority)
						return null;
					bin = _queue[_minPriority];
				}
				result = bin.removeRandom();
			}
			return result;
		}
		
		public function isEmpty():Boolean
		{
			return _minPriority > _maxPriority;
		}
	}
}