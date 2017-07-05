package remote2.core
{
	import flash.events.IEventDispatcher;
	
	import remote2.collections.IList;
	
	[Event(name="change")]
	
	/**
	 * ISelectableList 接口指示该实现器是一个支持 selectedIndex 属性的 IList 元素。 
	 * @author xujunjie
	 * @date 2013-5-48
	 * 
	 */	
	public interface ISelectableList extends IList, IEventDispatcher
	{
		/**
		 * 选中的序号 
		 * 
		 */		
		function set selectedIndex(value:int):void;
		function get selectedIndex():int;
	}
}