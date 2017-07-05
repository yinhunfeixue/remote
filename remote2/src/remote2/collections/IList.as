package remote2.collections
{
	
	/**
	 * 按顺序组织的项目的集合。提供基于索引的访问和处理方法
	 * @author 银魂飞雪
	 * @createDate 2011-3-29
	 */
	public interface IList
	{
		/**
		 * 集合的长度 
		 * 
		 */		
		function get length():int;
		
		/**
		 * 向列表末尾添加指定项目
		 * @param item 要添加的项
		 * 
		 */		
		function addItem(item:Object):void;
		
		/**
		 * 在指定的索引处添加项目 
		 * @param item 要添加的项
		 * @param index 添加位置
		 * 
		 */		
		function addItemAt(item:Object, index:int):void;
		
		/**
		 * 获取指定位置的项 
		 * @param index 位置
		 * @return 指定位置的项
		 * 
		 */		
		function getItemAt(index:int):Object;
		
		/**
		 * 获取子项的位置 
		 * @param item 子项
		 * @return 位置
		 * 
		 */		
		function getItemIndex(item:Object):int;
		
		/**
		 * 移除项 
		 * @param item 要移除的项
		 * @return 移除的项
		 * 
		 */		
		function removeItem(item:Object):Object;
		
		/**
		 * 移除指定位置的项
		 * @param index 要移除项的位置
		 * @return 移除的项
		 * 
		 */		
		function removeItemAt(index:int):Object;
		
		/**
		 * 移除所有子项 
		 * 
		 */		
		function removeAll():void;
		
		/**
		 * 移动项目到索引处，项目必须已存在
		 * @param item 子项
		 * @param index 新位置
		 * @return 子项
		 * 
		 */		
		function moveItem(item:Object, index:int):void;
		
		/**
		 * 转换成数组 
		 * @return 数组
		 * 
		 */		
		function toArray():Array;
	}
}