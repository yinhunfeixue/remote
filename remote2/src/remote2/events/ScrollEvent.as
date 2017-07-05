package remote2.events
{
	import flash.events.Event;
	
	
	/**
	 * 滚动事件
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class ScrollEvent extends Event
	{
		/**
		 * 水平滚动位置改变 
		 */		
		public static const HORIZONTAL_VALUE_CHANGED:String = "horizontalValueChanged";
		
		/**
		 * 竖直滚动位置改变 
		 */		
		public static const VERTICAL_VALUE_CHANGED:String = "verticalValueChanged";
		
		/**
		 * 最大水平滚动位置改变 
		 */		
		public static const MAX_HORIZONTAL_VALUE_CHANGED:String = "maxHorizontalValueChanged";
		
		/**
		 *  最大竖直滚动位置改变 
		 */		
		public static const MAX_VERTICAL_VALUE_CHANGED:String = "maxVerticalValueChanged";
		
		/**
		 * 改变后的值 
		 */		
		public var value:Number;
		
		public function ScrollEvent(type:String, value:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
		
		
		override public function clone():Event
		{
			return new ScrollEvent(type, value, bubbles, cancelable);
		}
		
	}
}