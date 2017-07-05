package remote2.components
{
	import flash.display.DisplayObject;
	
	import remote2.collections.IList;
	import remote2.core.IItemRender;
	import remote2.events.RendererExistenceEvent;
	import remote2.layouts.VerticalLayout;
	
	[Event(name="rendererAdd", type="remote2.events.RendererExistenceEvent")]
	[Event(name="rendererRemove", type="remote2.events.RendererExistenceEvent")]
	/**
	 * 数据源组件,用于根据数据源创建指定类型的IItemRender实例。
	 * 对于只用于显示，没有交互的场景，建议使用此类。
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-8
	 */	
	public class DataGroup extends Group
	{
		private var _dataProvider:IList;
		private var _dataProviderChanged:Boolean;
		
		private var _itemRender:Class;
		private var _itemRenderChanged:Boolean;
		
		private var _itemArr:Vector.<IItemRender>;
		
		/**
		 * 实例化
		 * 
		 */		
		public function DataGroup()
		{
			super();
		}
		
		/**
		 * 强制更新内容，一般情况下，当改变数据源中某个对象的属性，或者从数据源中添加/删除对象后调用此方法
		 * 
		 */		
		public function update():void
		{
			updateAllItem();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function initialize():void
		{
			if(layout == null)
			{
				layout = new VerticalLayout();
			}
			if(_itemRender == null)
				itemRender = ItemRender;
			super.initialize();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataProviderChanged || _itemRenderChanged)
			{
				if(_itemRenderChanged)
				{
					_itemRenderChanged = false;
					removeAllItem();
				}
				_dataProviderChanged = false;
				updateAllItem();
			}
		}
		/**
		 * 获取序号对应的IItemRender实例 
		 * @param index 序号
		 * @return IItemRender实例 
		 * 
		 */		
		public function getItemRenderByIndex(index:int):IItemRender
		{
			if(_itemArr == null)
				return null;
			for (var i:int = 0; i < _itemArr.length; i++) 
			{
				if(_itemArr[i].index == index)
					return _itemArr[i];
			}
			return null;
		}
		
		private function removeAllItem():void
		{
			if(_itemArr == null)
				return;
			removeItems(0, _itemArr.length);
		}
		
		private function addItem(index:int):IItemRender
		{
			if(_itemRender && _dataProvider && index >= 0 && index < _dataProvider.length)
			{
				var data:Object = _dataProvider.getItemAt(index);
				var result:IItemRender = new _itemRender();
				result.data = data;
				result.index = index;
				_itemArr.push(result);
				addChild(result as DisplayObject);
				if(hasEventListener(RendererExistenceEvent.RENDERER_ADD))
					dispatchEvent(new RendererExistenceEvent(RendererExistenceEvent.RENDERER_ADD, false, false, result, index, data));
				return result;
			}
			return null;
		}
		
		/**
		 * 移除范围内的子项 
		 * @param startIndex
		 * @param endIndex
		 * 
		 */		
		private function removeItems(startIndex:int, endIndex:int):void
		{
			if(startIndex < 0)
				startIndex = 0;
			if(endIndex > _itemArr.length)
				endIndex = _itemArr.length;
			if(startIndex >= endIndex)
				return;
			if(_itemArr == null)
				return;
			var count:int = endIndex - startIndex;
			while(count > 0)
			{
				removeItem(startIndex);
				count--;
			}
		}
		
		private function removeItem(index:int):IItemRender
		{
			if(index >= 0 && index < _itemArr.length)
			{
				var item:IItemRender = _itemArr[index];
				if(item)
				{
					removeChild(item as DisplayObject);
					_itemArr.splice(index, 1);
					if(hasEventListener(RendererExistenceEvent.RENDERER_REMOVE))
						dispatchEvent(new RendererExistenceEvent(RendererExistenceEvent.RENDERER_REMOVE, false, false, item, index, item.data));
					item.data = null;
					return item;
				}
			}
			return null;
		}
		
		/**
		 * 更新所有数据项 
		 * 
		 */		
		protected function updateAllItem():void
		{
			if(_itemArr == null)
				_itemArr = new Vector.<IItemRender>();
			if(_dataProvider == null)
				removeAllItem();
			else
			{
				for (var i:int = 0; i < _dataProvider.length; i++) 
				{
					if(i >= _itemArr.length)
					{
						addItem(i);
					}
					else
					{
						_itemArr[i].data = _dataProvider.getItemAt(i);
						_itemArr[i].index = i;
					}
				}
				if(i < _itemArr.length)
					removeItems(i, _itemArr.length);
			}
		}
		
		/**
		 * 数据源 
		 */
		public function get dataProvider():IList
		{
			return _dataProvider;
		}
		
		/**
		 * @private
		 */
		public function set dataProvider(value:IList):void
		{
			_dataProvider = value;
			_dataProviderChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 子项类型 
		 */
		public function get itemRender():Class
		{
			return _itemRender;
		}
		
		/**
		 * @private
		 */
		public function set itemRender(value:Class):void
		{
			if(_itemRender != value)
			{
				_itemRender = value;
				_itemRenderChanged = true;
				invalidateProperties();
			}
		}

		/**
		 * 所有IItemRender实例集合 
		 * 
		 */		
		public function get itemArr():Vector.<IItemRender>
		{
			return _itemArr;
		}

	}
}