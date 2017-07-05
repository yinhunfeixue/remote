package remote2.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * 所有加载项都加载完成，进入空闲状态后发出 
	 */	
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * 此事件每100毫秒触发一次，并不携带数量，因此需要的数据（比如已加载字节，总的字节数）需要从属性中取
	 */	
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	/**
	 * 加载器
	 * 支持队列加载，并可调整队列顺序
	 * @author 徐俊杰
	 * @date 2012-2-22
	 */
	public class LoaderLite extends EventDispatcher
	{
		private var _maxnumConnections:uint;
		private var _numConnections:uint;
		private var _waitItems:Vector.<ILoadItem>;
		private var _loadingItems:Vector.<ILoadItem>;
		private var _loadedItems:Vector.<ILoadItem>;
		private var _autoDeleteLoadedItem:Boolean;
		
		/**
		 * 所有已加载完成的项的字节数
		 * <p>删除加载完成的项，不会影响到此值;如果需要重置，可以执行reset方法</p>
		 */		
		private var _bytesLoadedTotal:Number = 0;
		
		/**
		 * 已工作完成的毫秒数，不包含空闲时间；如果当前处于工作状态，也不包含上次开始工作至现在的时间。 
		 */		
		private var _workedTime:Number = 0;
		
		private var _isFree:Boolean = true;
		
		/**
		 * 上次从空闲状态进入加载的时间戳 
		 */		
		private var _workStartTime:Number;
		
		/**
		 * 触发进度事件的触发器 
		 */		
		private var _progressTimer:Timer;
		
		/**
		 * 是否暂停 
		 */		
		private var _pause:Boolean = false;
		
		
		/**
		 * 实例化加载器 
		 * @param maxnumConnections 同时加载的最多数量
		 * @param autoDeleteLoadedItem 是否自动删除加载完成的项
		 * 
		 */			
		public function LoaderLite(maxnumConnections:uint = 3, autoDeleteLoadedItem:Boolean = true)
		{
			super();
			_maxnumConnections = maxnumConnections;
			_autoDeleteLoadedItem = autoDeleteLoadedItem;
			
			_waitItems = new Vector.<ILoadItem>();
			_loadedItems = new Vector.<ILoadItem>();
			_loadingItems = new Vector.<ILoadItem>();
		}
		
		/**
		 *  添加加载项
		 * <p>如果已存在相同<b>标识符</b>的加载项，不会操作</p>
		 * @param url 路径。
		 * @param loaderType 加载器类型，参考<a href='LoaderType.html'>LoaderType</a>; 如果为null，将根据文件类型创建。
		 * @param maxTries 最大重复次数。
		 * @param key 标识符，如果为null，则使用url。
		 * @param priority 优先级，值越大优先级越高，允许为负数，默认值为0
		 * @return 加载项
		 * 
		 */		
		public function addItem(url:String, loaderType:Class = null, maxTries:uint = 3, key:String = null, priority:int = 0, parameter:* = null):ILoadItem
		{
			return addItemAt(url, _waitItems.length, loaderType, maxTries, key, priority, parameter);
		}
		
		/**
		 * 获取加载项 
		 * @param key 标识符
		 * @return 加载项
		 * 
		 */		
		public function getItem(key:String):ILoadItem
		{
			var item:ILoadItem;
			for each(item in _waitItems)
			{
				if(item.key == key)
				{
					return item;
				}
			}
			for each(item in _loadingItems)
			{
				if(item.key == key)
				{
					return item;
				}
			}
			for each(item in _loadedItems)
			{
				if(item.key == key)
				{
					return item;
				}
			}
			return null;
		}
		
		/**
		 *  删除加载项
		 * <p>无论加载项处于什么状态，都将被删除，如果删除正在加载的项，会停止加载</p>
		 * @param item 要删除的加载项
		 * @return 被删除的加载项，如果要删除的项不在队列中，返回null
		 * 
		 */		
		public function removeItem(item:ILoadItem):ILoadItem
		{
			var itemArr:Vector.<ILoadItem>;
			switch(item.status)
			{
				case LoadItemStatus.LOADED:
					itemArr = _loadedItems;
					break;
				case LoadItemStatus.LOADING:
					itemArr = _loadingItems;
					break;
				default:
					itemArr = _waitItems;
					break;
			}
			var result:ILoadItem;
			var index:int = itemArr.indexOf(item);
			if(index != -1)
			{
				if(item.status == LoadItemStatus.LOADING)
				{
					item.stop();
				}
				removeItemListener(item);
				return itemArr.splice(index, 1)[0];
			}
			return null;
		}
		
		public function start():void
		{
			_pause = false;
			addLoading();
		}
		
		/**
		 * 正在加载的队列加载完成后，不会添加新的加载项，直到再次调用start()方法
		 *  
		 * @see #start()
		 */		
		public function stop():void
		{
			_pause = true;
		}
		
		/**
		 * 清除加载完成的项 
		 * 
		 */		
		public function clearLoadedItems():void
		{
			_loadedItems.splice(0, _loadedItems.length);
		}
		
		/**
		 * 清除所有的项，停止正在加载的项 
		 * 
		 */		
		public function clear():void
		{
			clearLoadedItems();
			_waitItems.splice(0, _waitItems.length);
			for each(var item:ILoadItem in _loadingItems)
			{
				item.stop();
			}
			_loadingItems.splice(0, _loadingItems.length);
		}
		
		
		
		/**
		 * 在等待队列中插入加载项 
		 * <p>如果已存在相同<b>标识符</b>的加载项，不会操作</p>
		 * @param url 路径。
		 * @param index 在等待队列的位置
		 * @param loaderType 加载器类型，参考LoaderType; 如果为null，将根据文件类型创建。
		 * @param maxTries 最大重复次数。
		 * @param key 标识符，如果为null，则使用url。
		 * @param priority 优先级，值越大优先级越高，允许为负数，默认值为0
		 * @return 加载项
		 * 
		 */		
		public function addItemAt(url:String, index:uint, loaderType:Class = null, maxTries:uint = 3, key:String = null, priority:int = 0, parameter:* = null):ILoadItem
		{
			
			var result:ILoadItem = LoadItemCreater.createItem(url, maxTries, loaderType, key);
			result.priority = priority;
			result.parameter = parameter;

			var oldItem:ILoadItem = getItem(result.key);
			
			if(oldItem != null)
			{
				oldItem.priority = priority;
				_waitItems.sort(sortFunction);
				return oldItem;  
			}
			if(index > _waitItems.length)
				index = _waitItems.length;
			_waitItems.splice(index, 0, result);
			_waitItems.sort(sortFunction);
			addLoading();
			return result;
		}
		
		private function sortFunction(itema:ILoadItem, itemb:ILoadItem):int
		{
			if(itemb.priority > itema.priority)
				return 1;
			return 0;
		}
		
		/**
		 * 设置等待队列中加载项的位置，此操作会影响加载的顺序。 
		 * @param item 要变化位置的加载项
		 * @param index 新的位置
		 * 
		 */		
		public function setItemIndex(item:ILoadItem, index:uint):void
		{
			var oldIndex:int = _waitItems.indexOf(item);
			if(oldIndex != -1)
			{
				_waitItems.splice(oldIndex, 1);
				_waitItems.splice(index, 0, item);
			}
		}
		
		/**
		 * 增加加要加载的项
		 * 
		 */		
		private function addLoading():void
		{
			if(!_pause)					//如果不是暂停状态
			{
				while(_loadingItems.length < _maxnumConnections &&_waitItems.length > 0)									//如果正在加载的项小于最大连接数，并且有等待的项
				{
					var item:LoadItem = _waitItems.shift() as LoadItem;
					item.addEventListener(Event.COMPLETE, item_completeHandler, false, int.MIN_VALUE);
					item.addEventListener(IOErrorEvent.IO_ERROR, item_ioErrorHandler);
					item.addEventListener(SecurityErrorEvent.SECURITY_ERROR, item_securityErrorHandler);
					item.status = LoadItemStatus.LOADING;
					item.triedNumber++;
					item.startTime = getTimer();
					(item as ILoadItem).start();
					_loadingItems.push(item);
					if(_isFree)					//如果是从空闲状态进入工作状态，开始计时
					{
						_isFree = false;
						_workStartTime = getTimer();
						if(_progressTimer == null)
							initProgressTimer();
						_progressTimer.start();
					}
				}
				
				if(_isFree == false && _waitItems.length == 0 && _loadingItems.length == 0)					//如果所有等待项已加载完成，则记录一下已工作时间
				{
					_isFree = true;
					_workedTime += (getTimer() - _workStartTime);
					_progressTimer.stop();
					dispatchEvent(new Event(Event.COMPLETE));
				}
			}
		}
		
		/**
		 * 上次记录的已加载的字节数 
		 */		
		private var _lastBytesLoaded:Number;
		
		/**
		 * 上次记录的时间 
		 */		
		private var _lastProgressTime:Number;
		
		/**
		 * 初始化进度触发器，但不会启动 
		 * 
		 */		
		private function initProgressTimer():void
		{
			_progressTimer = new Timer(1000);
			_progressTimer.addEventListener(TimerEvent.TIMER, progressTimer_Timerhandler);
			_lastBytesLoaded = 0;
			_lastProgressTime = getTimer();
		}
		
		protected function progressTimer_Timerhandler(event:TimerEvent):void
		{
			if(!_isFree)
			{
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false));
				_lastProgressTime = getTimer();
				_lastBytesLoaded = bytesLoadedTotal;
			}
		}
		
		private function item_securityErrorHandler(event:SecurityErrorEvent):void
		{
			var item:ILoadItem = event.currentTarget as ILoadItem;
			afterError(item);
		}
		
		private function item_ioErrorHandler(event:IOErrorEvent):void
		{
			var item:ILoadItem = event.currentTarget as ILoadItem;
			afterError(item);
		}
		
		private function afterError(item:ILoadItem):void
		{
			removeItemListener(item);
			if(_loadingItems.indexOf(item) >= 0)
				_loadingItems.splice(_loadingItems.indexOf(item), 1);
			if(item.triedNumber < item.maxTries)
			{
				_waitItems.push(item);
			}
			addLoading();
		}
		
		private function item_completeHandler(event:Event):void
		{
			var item:ILoadItem = event.currentTarget as ILoadItem;
			removeItemListener(item);
			item.completeTime = getTimer();
			item.status = LoadItemStatus.LOADED;
			
			_bytesLoadedTotal += item.bytesTotal;
			_loadingItems.splice(_loadingItems.indexOf(item), 1);
			
			if(!_autoDeleteLoadedItem)
			{
				_loadedItems.push(item);
			}
			addLoading();
		}
		
		private function removeItemListener(item:ILoadItem):void
		{
			item.removeEventListener(Event.COMPLETE, item_completeHandler);
			item.removeEventListener(IOErrorEvent.IO_ERROR, item_ioErrorHandler);
			item.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, item_securityErrorHandler);
		}
		
		/**
		 * 即时加载速度，字节/秒
		 * 
		 */		
		public function get speed():Number
		{
			if(getTimer() <= _lastProgressTime)
				return 0;
			var result:Number = (bytesLoadedTotal - _lastBytesLoaded) * 1000 / (getTimer() - _lastProgressTime);
			return result;
		}
		
		/**
		 * 平均加载速度，字节/秒
		 * 
		 */		
		public function get averageSpeed():Number
		{
			return bytesLoadedTotal * 1000 / totalTime;
		}
		
		/**
		 * 加载完成的比例0——1
		 * 如果要使用此属性，请勿设置自动删除已完成的项，否则会出现错误的值。
		 * 
		 */		
		public function get totalPercent():Number
		{
			var itemCount:int = _loadedItems.length + _loadingItems.length + _waitItems.length;
			var result:Number = 0;
			//ExternalInterface.call("console.log","progress trace:"+ (bytesTotalCurrent + "," + bytesTotalCurrent + "," + _loadingItems.length + "," +  itemCount));
			if(bytesTotalCurrent != 0)
				result += bytesLoadedCurrent / bytesTotalCurrent * (_loadingItems.length / itemCount);
			//ExternalInterface.call("console.log","progress trace:" + result);
			return result + _loadedItems.length / itemCount;
		}
		
		/**
		 *  加载消耗的总毫秒数，空闲时间不计算在内
		 * 
		 */		
		public function get totalTime():Number
		{
			if(_isFree)
				return _workedTime;
			else
				return _workedTime + (getTimer() - _workStartTime);
		}
		
		/**
		 * 已加载的所有数据字节数总和（包含加载完成的项和正在加载的项） 
		 * @return 
		 * 
		 */		
		public function get bytesLoadedTotal():Number
		{
			if(_isFree)
				return _bytesLoadedTotal;
			else
				return _bytesLoadedTotal + bytesLoadedCurrent;
		}
		
		/**
		 *  正在加载的全部项“已加载的字节数的和”
		 * 
		 */		
		public function get bytesLoadedCurrent():Number
		{
			var result:Number = 0;
			for each(var item:ILoadItem in _loadingItems)
			{
				result += item.bytesLoaded;
			}
			return result;
		}
		
		/**
		 *  正在加载的全部项“总字节数的和”
		 * 
		 */		
		public function get bytesTotalCurrent():Number
		{
			var result:Number = 0;
			for each(var item:ILoadItem in _loadingItems)
			{
				result += item.bytesTotal;
			}
			return result;
		}

		/**
		 * 加载器是否处于空闲状态 
		 */
		public function get isFree():Boolean
		{
			return _isFree;
		}

	}
}