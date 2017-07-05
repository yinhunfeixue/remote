package remote2.events
{
	import flash.events.Event;
	
	
	/**
	 * CloseEvent 类表示特定于弹出窗口的事件对象
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class CloseEvent extends Event
	{
		/**
		 * 关闭事件 
		 */		
		public static const CLOSE:String = "close";
		
		/**
		 * 关闭原因
		 */		
		public var detail:int;
		
		/**
		 * 关闭事件 
		 * @param type 事件类型
		 * @param bubbles 是否冒泡
		 * @param cancelable 是否可取消
		 * 
		 */		
		public function CloseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:CloseEvent = new CloseEvent(type, bubbles, cancelable);
			result.detail = detail;
			return result;
		}
	}
}