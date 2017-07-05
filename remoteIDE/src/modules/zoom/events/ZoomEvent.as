package modules.zoom.events
{
	import flash.events.Event;
	
	
	/**
	 * 缩放事件 
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-20
	 *
	 * */
	public class ZoomEvent extends Event
	{
		/**
		 * 放大 
		 */		
		public static const ZOOM_IN:String = "zoomIn";
		
		/**
		 * 缩小 
		 */		
		public static const ZOOM_OUT:String = "zoomOut";
		
		/**
		 * 重置 
		 */		
		public static const RESET:String = "reset";
		
		public function ZoomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}