package remote2.net
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * Loader加载项
	 * @author 徐俊杰
	 * @date 2012-2-23
	 * 
	 * @private
	 */
	public class LoaderItem extends LoadItem implements ILoadItem
	{
		
		/**
		 * 实例化 
		 * 
		 */		
		public function LoaderItem()
		{
			super();
			loader = new Loader();
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, eventHandler);
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, eventHandler);
			myLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, eventHandler);
		}
		
		public function get data():*
		{
			return myLoader.content;
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop():void
		{
			try
			{
				myLoader.close();
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function start():void
		{
			myLoader.load(new URLRequest(url));
		}
		
		private function get myLoader():Loader
		{
			return loader as Loader;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesLoaded():Number
		{
			var result:Number = myLoader.contentLoaderInfo.bytesLoaded;
			if(isNaN(result))
				return 0;
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesTotal():Number
		{
			var result:Number =  myLoader.contentLoaderInfo.bytesTotal;
			if(isNaN(result))
				return 0;
			return result;
		}
		
		
	}
}