package remote2.collections
{
	/**
	 * ArrayCollection 类是将 Array 公开为集合的封装类，可使用IList 接口的方法和属性进行访问和处理。对 ArrayCollection 实例进行操作会修改数据源；例如，如果对 ArrayCollection 使用 removeItemAt() 方法，就会删除基础 Array 中的项目。 
	 * @author xujunjie
	 * 
	 */	
	public class ArrayCollection implements IList
	{
		private var _source:Array;
		
		/**
		 * 实例化 
		 * @param source 源数据
		 * 
		 */		
		public function ArrayCollection(source:Array = null)
		{
			_source = source?source:new Array();
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get length():int
		{
			return _source.length;
		}
		/**
		 * @inheritDoc
		 */
		public function addItem(item:Object):void
		{
			_source.push(item)
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function addItemAt(item:Object, index:int):void
		{
			if(checkForRangeError(index, true, true))
				_source.splice(index, 0, item);
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function removeItem(item:Object):Object
		{
			var index:int = getItemIndex(item);
			if(index >= 0)
				return _source.splice(index, 1)[0];
			return null;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function removeItemAt(index:int):Object
		{
			if(checkForRangeError(index))
				return _source.splice(index, 1)[0];
			return null;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function getItemAt(index:int):Object
		{
			if(index >= 0 && index < _source.length)
				return _source[index];
			return null;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function getItemIndex(item:Object):int
		{
			return _source.indexOf(item);
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function removeAll():void
		{
			_source.splice(0);
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function moveItem(item:Object, index:int):void
		{
			if(checkForRangeError(index))
			{
				var oldIndex:int = getItemIndex(item);
				if(oldIndex >= 0 && oldIndex != index)
				{
					addItemAt(removeItemAt(oldIndex), index);	
				}
			}
		}
		
		/**
		 * 检查是序号是否在允许的范围内 
		 * @param index 序号
		 * @param throwError 序号不合法时是否抛出错误
		 * @param isAdd 序号是否是用于添加
		 * @return 序号合法返回true; 不合法，返回false
		 * 
		 */		
		private function checkForRangeError(index:int, throwError:Boolean = true, isAdd:Boolean = false):Boolean
		{
			var max:int = _source.length;
			if(isAdd)
				max = _source.length + 1;
			if(index >= 0 && index < max)
				return true;
			else
			{
				if(throwError)
					throw new RangeError("index " + index + " is outOfBounds");
				return false;
			}
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function toArray():Array
		{
			return _source.concat();
		}
		
		/**
		 * 源数据，此值永远不会为null。<br/>设置为null，等同设置为长度为0的Array 
		 * <br/>
		 * ArrayCollection 中的数据源。ArrayCollection 对象不提供对源数组进行的任何直接更改。始终使用 ICollectionView 或 IList 方法修改该集合。
		 * 
		 */		
		public function get source():Array
		{
			return _source;
		}
		
		public function set source(value:Array):void
		{
			if(value == null)
				value = new Array();
			_source = value;
		}	
	}
}