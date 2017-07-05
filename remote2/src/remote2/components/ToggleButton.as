package remote2.components
{
	import flash.events.MouseEvent;
	
	import remote2.components.supports.ToggleButtonBase;
	
	
	/**
	 * 切换按钮
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class ToggleButton extends ToggleButtonBase
	{
		public function ToggleButton()
		{
			super();
		}
		
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