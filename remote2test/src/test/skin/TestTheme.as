package test.skin
{
	import remote2.skins.remoteSkins.RemoteTheme;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-17
	 *
	 * */
	public class TestTheme extends RemoteTheme
	{
		public function TestTheme()
		{
			super();
			mapSkin("empty", EmptySkin);
			mapSkin("switchButton", SwitchButtonSkin);
		}
	}
}