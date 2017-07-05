package remote2.skins.remoteSkins
{
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class ToggleButtonSkin extends ButtonSkin
	{
		public function ToggleButtonSkin()
		{
			super();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "upAndSelected":
				case "overAndSelected":
				case "downAndSelected":
				case "disabledAndSelected":
					_lightColor = 0x999999;
					_darkColor = 0xeeeeee;
					_lightAlpha = 0.3;
					_drakAlpha = 0.6;
					break;
			}
		}
	}
}