package remote2.components
{
	import flash.events.Event;
	
	import remote2.collections.IList;
	import remote2.core.ISelectableList;
	import remote2.events.CollectionEvent;
	import remote2.layouts.HorizontalLayout;
	
	/**
	 * 按钮组
	 *
	 * @author xujunjie
	 * @date 2013-5-19 下午5:44:05
	 * 
	 */	
	public class ButtonBar extends List
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function ButtonBar()
		{
			super();
			allowMultipleSelection = false;
			itemRender = ButtonBarItemRender;
			layout = new HorizontalLayout();
		}
		
		private function get selectableDataProvider():ISelectableList
		{
			return dataProvider as ISelectableList;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function set dataProvider(value:IList):void
		{
			if(selectableDataProvider != null)
			{
				selectableDataProvider.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
				selectableDataProvider.removeEventListener(CollectionEvent.ADD, dataProvider_addHandler);
				selectableDataProvider.removeEventListener(CollectionEvent.REMOVE, dataProvider_removeHandler);
			}
			super.dataProvider = value as ISelectableList;
			if(value == null)
			{
				
			}
			else if(selectableDataProvider)
			{
				selectableDataProvider.addEventListener(Event.CHANGE, dataProvider_changeHandler);
				selectableDataProvider.addEventListener(CollectionEvent.ADD, dataProvider_addHandler);
				selectableDataProvider.addEventListener(CollectionEvent.REMOVE, dataProvider_removeHandler);
				selectedIndex = selectableDataProvider.selectedIndex;
			}
			else
				throw new Error("dataProvider must be ISelectableList");
		}
		
		private function dataProvider_removeHandler(event:CollectionEvent):void
		{
			update();
		}
		
		private function dataProvider_addHandler(event:CollectionEvent):void
		{
			update();
		}
		
		private function dataProvider_changeHandler(event:Event):void
		{
			selectedIndex = selectableDataProvider.selectedIndex;
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function commitSelectIndex():void
		{
			super.commitSelectIndex();
			if(selectableDataProvider)
				selectableDataProvider.selectedIndex = selectedIndex;
		}
		
		/**
		 * @private 
		 * 
		 */		
		override public function set selectedIndices(value:Array):void
		{
			throw new Error("unUseable");
		}
		
		/**
		 * @private 
		 * 
		 */		
		override public function set allowMultipleSelection(value:Boolean):void
		{
			if(value)
				throw new Error("unUseable");
			else
				super.allowMultipleSelection = false;
		}
	}
}