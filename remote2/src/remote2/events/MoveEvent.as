package remote2.events
{
	import flash.events.Event;
	
	
	/**
	 * 移动事件
	 * @author 银魂飞雪
	 * @createDate 2011-3-11
	 */
	public class MoveEvent extends Event
	{
		/**
		 * 移动事件 
		 */		
		public static const MOVE:String = "move";
		
		/**
		 * 旧x坐标 
		 */		
		public var oldX:Number;
		
		/**
		 * 旧y坐标 
		 */		
		public var oldY:Number;
		
		/**
		 * 实例化 
		 * @param type
		 * @param oldX
		 * @param oldY
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function MoveEvent(type:String, oldX:Number, oldY:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.oldX = oldX;
			this.oldY = oldY;
		}
		
		override public function clone():Event
		{
			return new MoveEvent(type, oldX, oldY, bubbles, cancelable);
		}
	}
}