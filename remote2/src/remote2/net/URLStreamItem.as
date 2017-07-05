package remote2.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	public class URLStreamItem extends LoadItem implements ILoadItem
	{
		private var _byteLoaded:Number = 0;
		private var _byteTotal:Number = 0;
		
		private var _data:ByteArray;
		public function URLStreamItem()
		{
			super();
			loader = new URLStream();
			urlStream.addEventListener(Event.COMPLETE, eventHandler);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, eventHandler);
			urlStream.addEventListener(ProgressEvent.PROGRESS, eventHandler);
			urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, eventHandler);
		}
		
		override protected function eventHandler(event:Event):void
		{
			if(event.type == ProgressEvent.PROGRESS)
			{
				var progressEvent:ProgressEvent = event as ProgressEvent;
				_byteLoaded = progressEvent.bytesLoaded;
				_byteTotal = progressEvent.bytesTotal;
			}
			super.eventHandler(event);
		}
		
		public function stop():void
		{
			try
			{
				urlStream.close();
			} 
			catch(error:Error) 
			{
				
			}
			
		}
		
		public function start():void
		{
			urlStream.load(new URLRequest(url));
		}
		
		public function get bytesLoaded():Number
		{
			return _byteLoaded;
		}
		
		public function get bytesTotal():Number
		{
			return _byteTotal;
		}
		
		override public function clear():void
		{
			if (_data)_data.clear();
			_data = null;
		}
		
		public function get data():*
		{
			if (!_data){
				_data = new ByteArray();
				urlStream.readBytes(_data,0,urlStream.bytesAvailable);
			}
			_data.position = 0;
			var bytes:ByteArray = new ByteArray();
			bytes.writeBytes(_data,0,_data.length);
			bytes.position = 0;
			return bytes;
		}
		
		private function get urlStream():URLStream
		{
			return loader as URLStream;
		}
	}
}