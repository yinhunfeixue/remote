package skins
{
	import remote2.components.TitleWindow;
	import remote2.skins.remoteSkins.TitleWindowSkin;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class PaddingTitleWindowSkin extends TitleWindowSkin
	{
		public function PaddingTitleWindowSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			target.filters = null;
			
			contentGroup = (target as TitleWindow).contentGroup;
			contentGroup.top = headHeight;
			contentGroup.bottom = 10;
			contentGroup.left = 10;
			contentGroup.right = 10;
			
			buttonSize.visible = false;
		}
	}
}