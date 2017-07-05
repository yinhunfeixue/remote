package remote2.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import remote2.core.ISelectableList;
	import remote2.events.CollectionEvent;
	
	[Event(name="change", type="flash.events.Event")]
	/**
	 * 选项卡容器，一般和ButtonBar配合使用
	 *
	 * @author xujunjie
	 * @date 2013-5-18 下午10:22:20
	 * 
	 */	
	public class ViewStack extends SkinnableComponent implements ISelectableList
	{
		private var _selectedIndex:int = -1;
		
		private var _proposedSelectedIndex:int = -1;
		
		private var _lastIndex:int = -1;
		private var _selectedIndexChanged:Boolean;
		
		public function ViewStack()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_selectedIndexChanged)
			{
				_selectedIndexChanged = false;
				commitSelectedIndex();
				
			}
		}
		/**
		 * @inheritDoc
		 */	
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var result:DisplayObject = super.addChildAt(child, index);
			addedChildHandler(child);
			dispatchEvent(new CollectionEvent(CollectionEvent.ADD, index));
			return result;
		}
		/**
		 * @inheritDoc
		 */	
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			removingChildHandler(child);
			var index:int = getChildIndex(child);
			var result:DisplayObject = super.removeChild(child);
			dispatchEvent(new CollectionEvent(CollectionEvent.REMOVE, index));
			return result;
		}
		
		private function removingChildHandler(child:DisplayObject):void
		{
			var index:int = getChildIndex(child);
			if(index <= selectedIndex)
			{
				selectedIndex--;
			}
		}
		
		private function addedChildHandler(child:DisplayObject):void
		{
			var index:int = getChildIndex(child);
			child.visible = false;
			if(selectedIndex == -1 || index <= selectedIndex)		//第一个子对象，或者添加位置，小于当前选中序号，则选中序号 + 1，以保证选中项不变
			{
				selectedIndex++;
			}
		}
		
		private function commitSelectedIndex():void
		{
			if(_proposedSelectedIndex < -1)
				_proposedSelectedIndex = -1;
			_lastIndex = _selectedIndex;
			_selectedIndex = _proposedSelectedIndex;
			_proposedSelectedIndex = -1;
			if(length > 0)				//如果有子项，必选一个
			{
				if(_selectedIndex == -1)
					_selectedIndex = 0;
			}
			if(_selectedIndex >= length)
				_selectedIndex = length - 1;
			
			if(_lastIndex >= 0)
			{
				var lastChild:DisplayObject = getChildAt(_lastIndex);
				if(lastChild)
					lastChild.visible = false;
			}
			if(_selectedIndex >= 0)
			{
				var currentChild:DisplayObject = getChildAt(_selectedIndex);
				currentChild.visible = true;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * @inheritDoc
		 */	
		public function set selectedIndex(value:int):void
		{
			if(value != selectedIndex)
			{
				_proposedSelectedIndex = value;
				_selectedIndexChanged = true;
				invalidateProperties();
			}
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndexChanged?_proposedSelectedIndex:_selectedIndex;
		}
		/**
		 * @inheritDoc
		 */	
		public function get selectedItem():Object
		{
			return getItemAt(selectedIndex);
		}
		/**
		 * @inheritDoc
		 */	
		public function get length():int
		{
			return numChildren;
		}
		/**
		 * @inheritDoc
		 */	
		public function addItem(item:Object):void
		{
			addChild(item as DisplayObject);
		}
		/**
		 * @inheritDoc
		 */	
		public function addItemAt(item:Object, index:int):void
		{
			addChildAt(item as DisplayObject, index);
		}
		/**
		 * @inheritDoc
		 */	
		public function getItemAt(index:int):Object
		{
			return getChildAt(index);
		}
		/**
		 * @inheritDoc
		 */	
		public function getItemIndex(item:Object):int
		{
			return getChildIndex(item as DisplayObject);
		}
		/**
		 * @inheritDoc
		 */	
		public function removeItem(item:Object):Object
		{
			return removeChild(item as DisplayObject);
		}
		/**
		 * @inheritDoc
		 */	
		public function removeItemAt(index:int):Object
		{
			return removeChildAt(index);
		}
		/**
		 * @inheritDoc
		 */	
		public function removeAll():void
		{
			removeAllChildren();
		}
		/**
		 * @inheritDoc
		 */	
		public function moveItem(item:Object, index:int):void
		{
			return setChildIndex(item as DisplayObject, index);
		}
		
		/**
		 * don't use this function
		 * @private 
		 * @return 
		 * 
		 */		
		public function toArray():Array
		{
			return null;
		}
	}
}