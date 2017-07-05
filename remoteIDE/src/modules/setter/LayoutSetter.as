package modules.setter
{
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-7-5
	 *
	 * */
	public class LayoutSetter extends SetterBase
	{
		public function LayoutSetter()
		{
			super();
			title = "布局";
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			addDefaultLabels(["left:", "right:", "top:", "bottom:", "percentWidth:", "percentHeight:"]);
		}
	}
}