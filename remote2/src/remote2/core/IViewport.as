package remote2.core
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 滚动视图接口
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-14
	 * */
	public interface IViewport extends IVisualElement, ILayoutElement, IEventDispatcher
	{
		/**
		 * 内容宽度 
		 * 
		 */		
		function get contentWidth():Number;
		
		/**
		 * 内容高度 
		 * 
		 */		
		function get contentHeight():Number;
		
		/**
		 * 水平滚动位置 
		 * 
		 */		
		function get horizontalScrollValue():Number;
		function set horizontalScrollValue(value:Number):void;
		
		/**
		 * 竖直滚动位置 
		 * 
		 */		
		function get verticalScrollValue():Number;
		function set verticalScrollValue(value:Number):void;
		
		/**
		 * 水平滚动速度 
		 * 
		 */		
		function get horizontalSpeed():Number;
		
		/**
		 * 竖直滚动速度 
		 * 
		 */		
		function get verticalSpeed():Number;
		
		/**
		 * 最大水平滚动位置 
		 * 
		 */		
		function get maxVScrollValue():Number;
		
		/**
		 * 最大竖直滚动位置 
		 * 
		 */		
		function get maxHScrollValue():Number;
	}
}