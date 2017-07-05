package remote2.events
{
	import flash.events.Event;
	
	
	/**
	 * 集合事件
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-20
	 *
	 * */
	public class CollectionEvent extends Event
	{
		/**
		 * 添加项
		 */		
		public static const ADD:String = "add";
		
		/**
		 * 移动项
		 */		
		public static const MOVE:String = "move";
		
		/**
		 * 刷新 
		 */		
		public static const REFRESH:String = "refresh";
		
		/**
		 * 删除项 
		 */		
		public static const REMOVE:String = "remove";
		
		/**
		 * 替换项 
		 */		
		public static const REPLACE:String = "replace";
		
		
		/**
		 * 变化的序号 
		 */		
		public var index:int;
		
		/**
		 * 实例化 
		 * @param type 事件类型
		 * @param index 变化的序号
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function CollectionEvent(type:String, index:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.index = index;
		}
		
		override public function clone():Event
		{
			return new CollectionEvent(type, index, bubbles, cancelable);
		}
	}
}