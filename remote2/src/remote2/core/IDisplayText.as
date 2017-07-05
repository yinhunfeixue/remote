package remote2.core
{
	import flash.events.IEventDispatcher;

	/**
	 * 文本显示接口 
	 * @author yinhunfeixue
	 * 
	 */	
	public interface IDisplayText extends IEventDispatcher
	{
		/**
		 * 设置文本内容 
		 * 
		 */		
		function set text(value:String):void;
		function get text():String;
		
		/**
		 * 是否截断 
		 * 
		 */		
		function get isTruncated():Boolean;
	}
}