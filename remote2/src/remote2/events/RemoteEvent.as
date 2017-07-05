package remote2.events
{
	import flash.events.Event;
	
	/**
	 * remote库无参数事件类 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RemoteEvent extends Event
	{
		/**
		 * 初始化完成事件 
		 */		
		public static const INITIALIZED:String = "initialized";
		
		/**
		 * 鼠标按下事件，和mouseDown不同，例如按钮允许自动重复且处理长按状态，则会定时发出此事件
		 */		
		public static const BUTTON_DOWN:String = "buttonDown";
		
		/**
		 * 创建完成事件，一个组件只会触发一次 
		 */		
		public static const CREATION_COMPLETE:String = "creationComplete";
		
		public function RemoteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}