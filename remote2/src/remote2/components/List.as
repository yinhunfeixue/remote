package remote2.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import remote2.collections.IList;
	import remote2.core.IItemRender;
	import remote2.core.remote_internal;
	import remote2.events.RendererExistenceEvent;
	import remote2.geom.Size;
	import remote2.layouts.ILayout;
	
	
	use namespace remote_internal;
	
	[Event(name="change", type="flash.events.Event")]
	/**
	 * 列表，允许选择多项
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-9
	 */	
	public class List extends SkinnableComponent
	{
		private var _scroller:Scroller;
		private var _dataGroup:DataGroup;
		
		private var _itemRender:Class;
		private var _itemRenderChanged:Boolean;
		
		private var _dataProvider:IList;
		private var _dataProviderChanged:Boolean;
		
		private var _selectedIndices:Array = [];
		private var _selectedIndexChanged:Boolean;
		
		private var _nextSelectIndices:Array = [];
		
		private var _allowMultipleSelection:Boolean = true;
		
		private var _containerLayout:ILayout;
		private var _containerLayoutChanged:Boolean;
		
		private var _labelFunction:Function;
		private var _labelFunctionChanged:Boolean;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function List()
		{
			super();
		}
		
		/**
		 * 强制更新内容，一般情况下，当改变数据源中某个对象的属性，或者从数据源中添加/删除对象后调用此方法 
		 * 
		 */		
		public function update():void
		{
			if(_dataGroup)
				_dataGroup.update();
		}
		
		override remote_internal function getMeasureSize():Size
		{
			return super.getMeasureSize();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_itemRenderChanged)
			{
				_itemRenderChanged = false;
				_dataGroup.itemRender = _itemRender;
			}
			if(_dataProviderChanged)
			{
				_dataProviderChanged = false;
				_dataGroup.dataProvider = _dataProvider;
			}
			if(_selectedIndexChanged)
			{
				_selectedIndexChanged = false;
				commitSelectIndex();
			}
			if(_containerLayoutChanged)
			{
				_containerLayoutChanged = false;
				_dataGroup.layout = _containerLayout;
			}
			if(_labelFunctionChanged)
			{
				_labelFunctionChanged = false;
				for each (var item:IItemRender in _dataGroup.itemArr) 
				{
					if(_labelFunction == null)
						item.label = null;
					else
						item.label = _labelFunction(item, item.index);
				}
				
			}
		}
		
		private function clearSelected():void
		{
			if(_selectedIndices == null)
				return;
			if(_dataGroup == null)
				return;
			for (var i:int = 0; i < _selectedIndices.length; i++) 
			{
				var item:IItemRender = _dataGroup.getItemRenderByIndex(_selectedIndices[i]);
				if(item)
					item.selected = false;
			}
		}
		
		/**
		 * 验证选中项 
		 * 排出不合法的选中项设置，同时设置itemrender的选中属性
		 */		
		protected function commitSelectIndex():void
		{
			clearSelected();
			if(_nextSelectIndices == null)
				_nextSelectIndices = [];
			for (var i:int = 0; i < _nextSelectIndices.length; i++) 
			{
				var item:IItemRender = _dataGroup.getItemRenderByIndex(_nextSelectIndices[i]);
				if(item)
				{
					item.selected = true;
					if(_selectedIndices.indexOf(item.index) == -1)
						_selectedIndices.push(item.index);
				}
			}
			_selectedIndices = _nextSelectIndices;
			_nextSelectIndices = [];
		}
		/**
		 * @inheritDoc
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			_dataGroup = new DataGroup();
			_dataGroup.addEventListener(RendererExistenceEvent.RENDERER_ADD, dataGroup_renderAddHandler);
			_dataGroup.addEventListener(RendererExistenceEvent.RENDERER_REMOVE, dataGroup_renderRemoveHandler);
			
			var c:ScrollContainer = new ScrollContainer();
			c.content = _dataGroup;
			
			_scroller = new Scroller();
			_scroller.viewport = c;
			addChild(_scroller);
		}
		
		protected function dataGroup_renderRemoveHandler(event:RendererExistenceEvent):void
		{
			var item:IItemRender = event.renderer;
			if(item)
			{
				if(item.selected)
					item.selected = false;
				item.removeEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
			}
		}
		
		private function item_mouseDownHandler(event:MouseEvent):void
		{
			var item:IItemRender = event.currentTarget as IItemRender;
			if(_allowMultipleSelection && event.ctrlKey)
				_nextSelectIndices = _selectedIndices.concat(item.index);
			else
				_nextSelectIndices = [item.index];
			_selectedIndexChanged = true;
			if(hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
			invalidateProperties();
		}
		
		protected function dataGroup_renderAddHandler(event:RendererExistenceEvent):void
		{
			var item:IItemRender = event.renderer;
			if(item)
			{
				item.addEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
				if(_selectedIndices != null && _selectedIndices.indexOf(event.index) >= 0)
					item.selected = true;
				if(_labelFunction != null)
				{
					item.label = _labelFunction(item.data, item.index);
				}
			}
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			_scroller.setActualSize(unscaleWidth, unscaleHeight);
		}
		
		/**
		 * 列表项类型，必须实现IItemRender接口 
		 * @see remote2.core.IItemRender
		 * 
		 */		
		public function get itemRender():Class
		{
			return _itemRender;
		}
		
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
		 * 选中项序号列表，当allowMultipleSelection为true时,可通过界面交互改变此属性。
		 * <p>通过编程方式设置此属性时，会强制把allowMultipleSelection设置为true</p>
		 * 
		 */		
		public function get selectedIndices():Array
		{
			if(_nextSelectIndices != null && _nextSelectIndices.length != 0)
				return _nextSelectIndices;
			return _selectedIndices;
		}
		
		public function set selectedIndices(value:Array):void
		{
			_nextSelectIndices = value;
			_selectedIndexChanged = true;
			_allowMultipleSelection = true;
			invalidateProperties();
		}
		
		/**
		 * 当前选中项序号，有多个选中项时，此属性表示最后选中的一项 
		 * 
		 */		
		public function get selectedIndex():int
		{
			if(selectedIndices != null && selectedIndices.length > 0)
				return selectedIndices[selectedIndices.length - 1];
			return -1;
		}
		
		public function set selectedIndex(value:int):void
		{
			if(value == -1)
				_nextSelectIndices = null;
			else
				_nextSelectIndices = [value];
			_selectedIndexChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 当前选中项，有多个选中项时，此属性表示最后选中的一项 
		 * 
		 */		
		public function get selectedItem():*
		{
			if(selectedIndex == -1)
				return null;
			return _dataProvider.getItemAt(selectedIndex);
		}
		
		public function set selectedItem(value:*):void
		{
			selectedIndex = _dataProvider.getItemIndex(value);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function get layout():ILayout
		{
			return _containerLayout;
		}
		
		override public function set layout(value:ILayout):void
		{
			if(layout != value)
			{
				_containerLayout = value;
				_containerLayoutChanged = true;
				invalidateProperties();
			}
		}

		/**
		 * 是否允许多选 
		 */
		public function get allowMultipleSelection():Boolean
		{
			return _allowMultipleSelection;
		}

		/**
		 * @private
		 */
		public function set allowMultipleSelection(value:Boolean):void
		{
			_allowMultipleSelection = value;
		}

		/**
		 * 用户提供的函数，在每个项目上运行以确定其标签文字。
		 * <br/>
		 * @example labelFunction(item:Object, column:int):String 
		 */
		public function get labelFunction():Function
		{
			return _labelFunction;
		}

		/**
		 * @private
		 */
		public function set labelFunction(value:Function):void
		{
			_labelFunction = value;
			_labelFunctionChanged = true;
			invalidateProperties();
		}

		
	}
}