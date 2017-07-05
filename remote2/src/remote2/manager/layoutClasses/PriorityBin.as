package remote2.manager.layoutClasses
{
	import flash.utils.Dictionary;
	
	/**
	 * 队列的一项，绝大部分开发者不需要使用
	 * @private
	 * @author yinhunfeixue
	 * 
	 */	
	public class PriorityBin
	{
		private var _length:int;
		private var _items:Dictionary = new Dictionary();
		
		public function PriorityBin()
		{
		}
		
		public function addObject(obj:*):void
		{
			if(!contains(obj))
			{
				_items[obj ] = true;
				_length++;
			}
		}
		
		public function contains(key:*):Boolean
		{
			return _items[key];
		}
		
		public function removeRandom():*
		{
			var result:*;
			if(!_items)
				return null;
			for (var key:* in _items) 
			{
				result = key;
				delete _items[key];
				_length--;
				return result;
			}
		}

		public function get length():int
		{
			return _length;
		}

	}
}