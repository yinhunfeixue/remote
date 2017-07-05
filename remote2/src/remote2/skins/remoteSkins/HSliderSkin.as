package remote2.skins.remoteSkins
{
	import remote2.components.Button;
	
	public class HSliderSkin extends RemoteSkin
	{
		public var thumb:Button;
		public var track:Button;
		
		public function HSliderSkin()
		{
			super();
		}
		
		override public function install():void
		{
			track = new Button();
			track.height = 6;
			track.percentWidth = 100;
			track.verticalCenter = 0;
			track.skinClass = HSliderTrackSkin;
			target.addChild(track);
			
			thumb = new Button();
			thumb.width = 10;
			thumb.percentHeight = 100;
			thumb.verticalCenter = 0;
			target.addChild(thumb);
		}
		
		override public function uninstall():void
		{
			target.removeChild(thumb);
			target.removeChild(track);
		}
	}
}