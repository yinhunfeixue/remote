package remote2.components
{
	import remote2.components.supports.ToggleButtonBase;
	import remote2.core.IItemRender;
	
	/**
	 * 默认的按钮组数据项
	 *
	 * @author xujunjie
	 * @date 2013-5-19 下午6:23:38
	 * 
	 */	
	public class ButtonBarItemRender extends ToggleButtonBase implements IItemRender
	{
		private var _data:Object;
		private var _selected:Boolean;
		private var _index:int;
		
		private var _dataChanged:Boolean;
		
		public function ButtonBarItemRender()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataChanged)
			{
				_dataChanged = false;
				if(data)
					label = data.toString();
				else
					label = "";
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get data():*
		{
			return _data;
		}
		
		public function set data(value:*):void
		{
			_data = value;
			_dataChanged = true;
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		public function get index():uint
		{
			return _index;
		}
		
		public function set index(value:uint):void
		{
			_index = value;
		}
	}
}