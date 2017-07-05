package remote2.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * URLLoader加载项
	 * @author 徐俊杰
	 * @date 2012-2-22
	 * 
	 * @private
	 */
	public class URLLoaderItem extends LoadItem implements ILoadItem
	{

		/**
		 * 实例化 
		 * 
		 */		
		public function URLLoaderItem()
		{
			super();
			loader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, eventHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, eventHandler);
			urlLoader.addEventListener(Event.COMPLETE, eventHandler);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, eventHandler);
		}
		
		public function get data():*
		{
			return urlLoader.data;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function stop():void
		{
			try
			{
				urlLoader.close();
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
			urlLoader.load(new URLRequest(url));
		}
		
		protected function get urlLoader():URLLoader
		{
			return loader as URLLoader;
		}

		
		public function get bytesLoaded():Number
		{
			var result:Number =  urlLoader.bytesLoaded;
			if(isNaN(result))
				return 0;
			return result;
		}
		
		public function get bytesTotal():Number
		{
			var result:Number =  urlLoader.bytesTotal;
			if(isNaN(result))
				return 0;
			return result;
		}
		
	}
}