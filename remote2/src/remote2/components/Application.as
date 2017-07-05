package remote2.components
{
	import remote2.events.EventMap;

	/**
	 * 应用程序，提供安装和卸载方法
	 * 提示使用舞台监听的接口，在卸载时会自动移除舞台的监听
	 * @author xujunjie
	 * 
	 */	
	public class Application extends Group
	{
		private var _eventMap:EventMap;
		
		public function Application()
		{
			super();
		}
		
		public function install():void
		{
			
		}
		
		public function addStageListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_eventMap.mapEvent(stage, type, listener, useCapture, priority, useWeakReference);
		}
		
		public function uninstall():void
		{
			_eventMap.unmapAll();
		}
	}
}