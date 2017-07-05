package remote2.components
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import remote2.components.supports.ItemRenderBase;
	
	
	/**
	 * 默认的数据项，显示data的toString()文本内容
	 * <p><b>自定义数据项，建议继承ItemRenderBase，而不是此类</b></p>
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-8
	 */	
	public class ItemRender extends ItemRenderBase
	{
		private var _labelDisplay:Label;
		private var _dataChanged:Boolean;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ItemRender()
		{
			super();

		}

		override protected function createChildren():void
		{
			super.createChildren();
			_labelDisplay = new Label();
			_labelDisplay.horizontalCenter = 0;
			_labelDisplay.verticalCenter = 0;
			addChild(_labelDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataChanged)
			{
				_dataChanged = false;
				if(data != null)
					_labelDisplay.text = label?label:data.toString()
				else
					_labelDisplay.text = "";
			}
		}
		/**
		 * @inheritDoc
		 */	
		override public function set data(value:*):void
		{
			super.data = value;
			_dataChanged = true;
			invalidateProperties();
		}
	}
}