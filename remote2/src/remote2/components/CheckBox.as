package remote2.components
{
	import flash.events.MouseEvent;
	
	import remote2.components.supports.ToggleButtonBase;
	
	/**
	 * 多选控件
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class CheckBox extends ToggleButtonBase
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function CheckBox()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function mouseEventHandler(event:MouseEvent):void
		{
			super.mouseEventHandler(event);
			if(event.type == MouseEvent.CLICK)
			{
				if(enabled)
					selected = !selected;
			}
		}
	}
}