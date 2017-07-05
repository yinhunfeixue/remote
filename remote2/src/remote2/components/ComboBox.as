package remote2.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import remote2.collections.IList;
	import remote2.core.IItemRender;
	import remote2.core.RemoteGlobals;
	import remote2.enums.Direction;
	import remote2.events.ResizeEvent;
	
	/**
	 * 下拉控件
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-15
	 */	
	public class ComboBox extends SkinnableComponent
	{
		protected function get dropList():List
		{
			return findSkinPart("dropList");
		}
		
		protected function get comboButton():Button
		{
			return findSkinPart("comboButton");
		}
		
		private var _isOpen:Boolean;
		private var _isOpenChanged:Boolean;
		
		private var _dataProvider:IList;
		private var _dataProviderChanged:Boolean;
		
		private var _selectedIndex:int = -1;
		private var _selectedIndexChanged:Boolean;
		
		private var _prompt:String = "";
		private var _promptChanged:Boolean;
		
		private var _labelFunction:Function;
		private var _labelFunctionChanged:Boolean;
		
		private var _listDirection:int = Direction.DOWN;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ComboBox()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_promptChanged)
			{
				_promptChanged = false;
				if(_selectedIndex < 0)
					comboButton.label = _prompt;
			}
			if(_selectedIndexChanged)
			{
				_selectedIndexChanged = false;
				commitSelectedIndex();
				dropList.selectedIndex = _selectedIndex;
				if(_selectedIndex < 0)
					comboButton.label = _prompt;
				else if(selectedItem)
					comboButton.label = itemToLabel(selectedItem, selectedIndex);
			}
			if(_dataProviderChanged)
			{
				_dataProviderChanged = false;
				commitSelectedIndex();
				dropList.dataProvider = _dataProvider;
				dropList.selectedIndex = _selectedIndex;
				if(selectedItem)
					comboButton.label = itemToLabel(selectedItem, selectedIndex);
			}
			if(_isOpenChanged)
			{
				_isOpenChanged = false;
				commitDropList();
			}
			if(_labelFunctionChanged)
			{
				_labelFunctionChanged = false;
				dropList.labelFunction = _labelFunction;
			}
			
		}
		
		private function itemToLabel(item:Object, index:int):String
		{
			if(_labelFunction == null)
				return item.toString();
			return _labelFunction(item, index);
		}
		
		private function invalidateOpen():void
		{
			_isOpenChanged = true;
			invalidateProperties();
		}
		
		private function commitDropList():void
		{
			var layer:DisplayObjectContainer = RemoteGlobals.popupLayer;
			if(_isOpen)
			{
				if(stage)
				{
					if(!layer.contains(dropList))
						layer.addChild(dropList);
					stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler, false, 0, true);
				}
			}
			else
			{
				if(layer)
				{
					if(layer.contains(dropList))
						layer.removeChild(dropList);
					
				}
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
			}
		}
		
		protected function stage_mouseDownHandler(event:MouseEvent):void
		{
			if(event.target == null || !dropList.contains(event.target as DisplayObject))
			{
				_isOpen = false;
				invalidateOpen();
			}
		}
		/**
		 * @inheritDoc
		 */	
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			dropList.addEventListener(Event.CHANGE, dropList_changeHandler);
			dropList.addEventListener(ResizeEvent.RESIZE, dropList_resizeHandler);
			comboButton.addEventListener(MouseEvent.MOUSE_DOWN, comboButton_mouseDownHandler);
		}
		
		protected function dropList_resizeHandler(event:Event):void
		{
			var point:Point = comboButton.localToGlobal(new Point());
			dropList.x = point.x;
			if(_listDirection == Direction.UP)
				dropList.y = point.y - dropList.height;
			else
				dropList.y = point.y + comboButton.height;
		}
		
		protected function dropList_changeHandler(event:Event):void
		{
			selectedIndex = dropList.selectedIndex;
			_isOpen = false;
			invalidateOpen();
		}
		
		protected function comboButton_mouseDownHandler(event:MouseEvent):void
		{
			_isOpen = !_isOpen;
			invalidateOpen();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function onSkinRemoveing():void
		{
			super.onSkinRemoveing();
			dropList.removeEventListener(Event.CHANGE, dropList_changeHandler);
			dropList.removeEventListener(ResizeEvent.RESIZE, dropList_resizeHandler);
			comboButton.removeEventListener(MouseEvent.MOUSE_DOWN, comboButton_mouseDownHandler);
		}
		
		private function commitSelectedIndex():void
		{
			if(_dataProvider == null)
				_selectedIndex = -1;
			if(_selectedIndex < -1)
				_selectedIndex = -1;
			if(_dataProvider != null && _selectedIndex >= _dataProvider.length)
				_selectedIndex = _dataProvider.length - 1;
		}
		
		/**
		 * 无选中项时，显示的提示文字 
		 * @return 
		 * 
		 */		
		public function get prompt():String
		{
			return _prompt;
		}
		
		public function set prompt(value:String):void
		{
			if(value == null)
				value = "";
			if(_prompt != value)
			{
				_prompt = value;
				_promptChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * 选中项序号
		 * 
		 */		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			if(value < -1)
				value = -1;
			if(_selectedIndex != value)
			{
				_selectedIndex = value;
				_selectedIndexChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * 数据源 
		 * 
		 */		
		public function get dataProvider():IList
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:IList):void
		{
			_dataProvider = value;
			_dataProviderChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 选中项 
		 * 
		 */		
		public function get selectedItem():Object
		{
			if(selectedIndex == -1)
				return 0;
			return _dataProvider.getItemAt(selectedIndex);
		}
		
		public function set selectedItem(value:Object):void
		{
			if(dataProvider)
			{
				var index:int = dataProvider.getItemIndex(value);
				selectedIndex = index;
			}
		}
		
		/**
		 * 列表出现的方向，取值为 Direction.DOWN/Direction.UP。
		 * 此值会在下一次打开列表时生效
		 * 
		 * @see remote2.enums.Direction
		 * @default Direction.DOWN
		 */
		public function get listDirection():int
		{
			return _listDirection;
		}
		
		/**
		 * @private
		 */
		public function set listDirection(value:int):void
		{
			_listDirection = value;
		}
		
		/**
		 * 下拉列表的数据项文本转换方法 
		 * @return 
		 * 
		 */		
		public function get labelFunction():Function
		{
			return _labelFunction;
		}
		
		public function set labelFunction(value:Function):void
		{
			_labelFunction = value;
			_labelFunctionChanged = true;
			invalidateProperties();
		}
		
		
	}
}