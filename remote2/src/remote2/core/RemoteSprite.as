package remote2.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * remote框架基础显示对象
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-13
	 * */
	public class RemoteSprite extends Sprite
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function RemoteSprite()
		{
			super();
		}
		
		/**
		 * 发出事件前先检查是否有事件监听，如果有，才发出事件 
		 * @param event 要发出的事件
		 * 
		 */		
		public function dispatchEventWithCheck(event:Event):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event);
		}
	}
}