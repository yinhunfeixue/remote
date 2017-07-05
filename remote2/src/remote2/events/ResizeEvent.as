package remote2.events
{
	import flash.events.Event;
	
	
	/**
	 * 尺寸事件
	 * @author 银魂飞雪
	 * @createDate 2011-2-26
	 */
	public class ResizeEvent extends Event
	{
		public static const RESIZE:String = "resize";
		
		/**
		 * 旧宽度 
		 */		
		public var oldWidth:Number;
		
		/**
		 * 旧高度 
		 */		
		public var oldHeight:Number;
		
		/**
		 * 实例化 
		 * @param type
		 * @param oldWidth
		 * @param oldHeight
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ResizeEvent(type:String, oldWidth:Number, oldHeight:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.oldWidth = oldWidth;
			this.oldHeight = oldHeight;
		}
		
		override public function clone():Event
		{
			return new ResizeEvent(type, oldWidth, oldHeight, bubbles, cancelable);
		}
	}
}