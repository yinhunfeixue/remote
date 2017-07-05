package remote2.net
{
	import flash.events.IEventDispatcher;
	

	/**
	 * 加载项接口
	 * @author 徐俊杰
	 * @date 2012-2-22
	 * 
	 * @private
	 */
	public interface ILoadItem extends IEventDispatcher
	{
		/**
		 * 停止加载
		 * 
		 */		
		function stop():void;
		
		/**
		 * 开始加载
		 * 
		 */		
		function start():void;
		
		/**
		 * 加载器 
		 */
		function get loader():*;
		function set loader(value:*):void;
		
		/**
		 * 加载状态，参考LoadItemStatus类 
		 * @see LoadItemStatus
		 */
		function get status():int;
		function set status(value:int):void;
		
		/**
		 * 加载的字节数，未开始加载的项，此值为0 
		 */
		function get bytesLoaded():Number;
		
		/**
		 * 总的字节数，未开始加载的项，此值为0
		 */
		function get bytesTotal():Number;
		
		/**
		 *  已消耗的加载时间
		 */
		function get time():Number;
		
		/**
		 *  已用的加载次数，对于从未开始加载的对象；对于第一次开始加载的对象此值为1
		 */
		function get triedNumber():uint;
		function set triedNumber(value:uint):void;
		/**
		 *  尝试加载的最大次数
		 *  尝试的数次超过此值，仍然未加载成功的项，将停止加载
		 */
		function get maxTries():uint;
		function set maxTries(value:uint):void;
		
		/**
		 * 标识符 
		 */
		function get key():String;
		function set key(value:String):void;
		
		/**
		 * 路径 
		 */
		function get url():String;
		function set url(value:String):void;
		
		/**
		 * 开始加载时间 
		 */
		function get startTime():Number;
		function set startTime(value:Number):void;
		
		/**
		 * 加载完成时间 
		 */
		function get completeTime():Number;
		function set completeTime(value:Number):void;
		
		/**
		 * 加载的数据 
		 * @return 
		 * 
		 */		
		function get data():*;
		
		/**
		 * 优先级 
		 * 
		 */		
		function get priority():int;
		function set priority(value:int):void;
		
		/**
		 * 设置的参数 
		 * 
		 */		
		function get parameter():*;
		function set parameter(value:*):void;

		/**
		 * 添加常见事件处理 
		 * @param completeHandler 加载完成处理,参数类型flash.events.Event
		 * @param progressHandler 进度调用处理, 参数类型flash.events.ProgressEvent
		 * @param io_errorHandler IO错误处理,参数类型flash.events.IOErrorEvent
		 * @param securityErrorHandler 安全沙箱错误处理,参数flash.events.SecurityErrorEvent
		 * @return 当前加载项
		 * 
		 * @see flash.events.Event
		 * @see flash.events.ProgressEvent
		 * @see flash.events.IOErrorEvent
		 * @see flash.events.SecurityErrorEvent
		 * 
		 */		
		function addEventListeners(completeHandler:Function, progressHandler:Function = null, io_errorHandler:Function = null, securityErrorHandle:Function = null):ILoadItem;
		
		/**
		 * 删除事件处理 
		 * @param completeHandler
		 * @param progressHandler
		 * @param ioErrorHandler
		 * @param securityErrorHandler
		 * 
		 */		
		function removeEventListeners(completeHandler:Function, progressHandler:Function=null, ioErrorHandler:Function=null, securityErrorHandler:Function=null):void;
	}
}