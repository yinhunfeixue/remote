package remote2.core
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 数据项接口
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-8
	 */
	public interface IItemRender extends IUIComponent, IVisualElement,IEventDispatcher
	{
		/**
		 * 数据 
		 * 
		 */		
		function get data():*;
		function set data(value:*):void;
		
		/**
		 * 数据项序号 
		 * 
		 */		
		function get index():uint;
		function set index(value:uint):void;
		
		/**
		 * 是否选中 
		 * 
		 */		
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
		/**
		 * 显示的文本标签，此属性一般在纯文本时使用，对于复杂数据项，可忽略此属性。
		 * 
		 */		
		function get label():String;
		function set label(value:String):void;
	}
}