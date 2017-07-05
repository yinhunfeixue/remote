package remote2.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.getTimer;
	
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	
	/**
	 * 加载项
	 * @author 徐俊杰
	 * @date 2012-2-22
	 */
	public class LoadItem extends EventDispatcher
	{
		/**
		 * 默认加载结束后的处理 
		 */		
		protected var completeHandlers:Array = [];
		
		/**
		 * 默认加载进度中的处理 
		 */	
		protected var progressHandlers:Array = [];
		
		/**
		 * 默认IO错误的处理 
		 */	
		protected var ioErrorHandlers:Array = [];
		
		/**
		 * 默认安全沙箱错误的处理 
		 */	
		protected var securityErrorHandlers:Array = [];
		
		private var _loader:*;
		
		private var _status:int;
		
		private var _startTime:Number;
		
		private var _completeTime:Number;
		
		private var _tringNumber:uint;
		
		private var _maxTries:uint;
		
		private var _key:String;
		
		private var _url:String;
		
		private var _priority:int;
		
		private var _parameter:*;
		
		/**
		 *  实例化加载项 
		 * 
		 */		
		public function LoadItem()
		{
			
			_status = LoadItemStatus.WAIT;
		}
		
		/**
		 * 加载器 
		 */
		public function get loader():*
		{
			return _loader;
		}
		
		/**
		 * @private
		 */
		public function set loader(value:*):void
		{
			_loader = value;
		}
		
		/**
		 * 加载状态，参考LoadItemStatus类 
		 * @see LoadItemStatus
		 */
		public function get status():int
		{
			return _status;
		}
		
		/**
		 * @private
		 */
		public function set status(value:int):void
		{
			_status = value;
		}
		
		/**
		 *  已消耗的加载时间
		 */
		public function get time():Number
		{
			if(_status == LoadItemStatus.WAIT)
				return 0;
			else if(_status == LoadItemStatus.LOADED)
				return _completeTime - _startTime;
			return getTimer() - _startTime;
		}
		
		/**
		 *  已经尝试过加载的次数，每次开始加载时，此值将加1
		 *  第一次加载开始后，此值为1
		 */
		public function get triedNumber():uint
		{
			return _tringNumber;
		}
		
		/**
		 * @private
		 */
		public function set triedNumber(value:uint):void
		{
			_tringNumber = value;
		}
		
		/**
		 *  尝试加载的最大次数
		 *  尝试的数次超过此值，仍然未加载成功的项，将停止加载
		 */
		public function get maxTries():uint
		{
			return _maxTries;
		}
		
		/**
		 * @private
		 */
		public function set maxTries(value:uint):void
		{
			_maxTries = value;
		}
		
		/**
		 * 标识符 
		 */
		public function get key():String
		{
			if(_key != null)
				return _key;
			else
				return _url;
		}
		
		/**
		 * @private
		 */
		public function set key(value:String):void
		{
			_key = value;
		}
		
		/**
		 * 路径 
		 */
		public function get url():String
		{
			return _url;
		}
		
		/**
		 * @private
		 */
		public function set url(value:String):void
		{
			_url = value;
		}
		
		/**
		 * 开始加载时间 
		 */
		public function get startTime():Number
		{
			return _startTime;
		}
		
		/**
		 * @private
		 */
		public function set startTime(value:Number):void
		{
			_startTime = value;
		}
		
		/**
		 * 加载完成时间 
		 */
		public function get completeTime():Number
		{
			return _completeTime;
		}
		
		/**
		 * @private
		 */
		public function set completeTime(value:Number):void
		{
			_completeTime = value;
		}
		
		protected function eventHandler(event:Event):void
		{
			var i:int;
			switch(event.type)
			{
				case Event.COMPLETE:
				{
					if(completeHandlers != null)
					{
						for(i = 0; i < completeHandlers.length; i++)
							completeHandlers[i](this);
						completeHandlers = [];
						clear();
					}
					break;
				}
				case ProgressEvent.PROGRESS:
				{
					if(progressHandlers != null)
					{
						for(i = 0; i < progressHandlers.length; i++)
							progressHandlers[i](this);
						progressHandlers = [];
					}
					break;
				}
				case IOErrorEvent.IO_ERROR:
				{
					if(ioErrorHandlers != null)
					{
						for(i = 0; i < ioErrorHandlers.length; i++)
							ioErrorHandlers[i](this);
						ioErrorHandlers = [];
					}
					break;
				}
				case SecurityErrorEvent.SECURITY_ERROR:
				{
					if(securityErrorHandlers != null)
					{
						for(i = 0; i < securityErrorHandlers.length; i++)
							securityErrorHandlers[i](this);
						securityErrorHandlers = [];
					}
				}
			}
			if(hasEventListener(event.type))
				dispatchEvent(event);
		}
		
		public function clear():void
		{
			
		}
		
		/**
		 * 添加常见事件处理 
		 * @param completeHandler 加载完成处理,参数类型IloadItem
		 * @param progressHandler 进度调用处理, 参数类型IloadItem
		 * @param io_errorHandler IO错误处理,参数类型IloadItem
		 * @param securityErrorHandler 安全沙箱错误处理,参数类型IloadItem
		 * @return 当前加载项
		 * 
		 * @see flash.events.Event
		 * @see flash.events.ProgressEvent
		 * @see flash.events.IOErrorEvent
		 * @see flash.events.SecurityErrorEvent
		 * 
		 */		
		public function addEventListeners(completeHandler:Function, progressHandler:Function=null, ioErrorHandler:Function=null, securityErrorHandler:Function=null):ILoadItem
		{
			if(completeHandler != null)
				this.completeHandlers.push(completeHandler);
			if(progressHandler != null)
				this.progressHandlers.push(progressHandler);
			if(ioErrorHandler != null)
				this.ioErrorHandlers.push(ioErrorHandler);
			if(securityErrorHandler != null)
				this.securityErrorHandlers.push(securityErrorHandler);
			if(this.status == LoadItemStatus.LOADED && completeHandlers != null)
				for(var i:int = 0; i < completeHandlers.length; i++)
					completeHandlers[i](this);
			return this as ILoadItem;
		}
		
		public function removeEventListeners(completeHandler:Function, progressHandler:Function=null, ioErrorHandler:Function=null, securityErrorHandler:Function=null):void
		{
			var index:int;
			if(completeHandlers != null)
			{
				index = completeHandlers.indexOf(completeHandler);
				if(index >= 0)
					completeHandlers.splice(index, 1);
			}
			if(progressHandlers != null)
			{
				index = progressHandlers.indexOf(progressHandler);
				if(index >= 0)
					progressHandlers.splice(index, 1);
			}
			if(ioErrorHandlers != null)
			{
				index = ioErrorHandlers.indexOf(ioErrorHandler);
				if(index >= 0)
					ioErrorHandlers.splice(index, 1);
			}
			if(securityErrorHandlers != null)
			{
				index = securityErrorHandlers.indexOf(securityErrorHandler);
				if(index >= 0)
					securityErrorHandlers.splice(index, 1);
			}
		}
		
		/**
		 * 优先级 
		 */
		public function get priority():int
		{
			return _priority;
		}
		
		/**
		 * @private
		 */
		public function set priority(value:int):void
		{
			_priority = value;
		}

		/**
		 * 参数 
		 */
		public function get parameter():*
		{
			return _parameter;
		}

		/**
		 * @private
		 */
		public function set parameter(value:*):void
		{
			_parameter = value;
		}

		
	}
}