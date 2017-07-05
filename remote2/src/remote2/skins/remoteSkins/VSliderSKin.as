package remote2.skins.remoteSkins
{
	import remote2.components.Button;
	
	public class VSliderSKin extends RemoteSkin
	{
		public var thumb:Button;
		public var track:Button;
		
		public function VSliderSKin()
		{
			super();
		}
		
		override public function install():void
		{
			track = new Button();
			track.width = 6;
			track.percentHeight = 100;
			track.horizontalCenter = 0;
			track.skinClass = VSliderTrackSkin;
			target.addChild(track);
			
			thumb = new Button();
			thumb.height = 10;
			thumb.percentWidth = 100;
			thumb.horizontalCenter = 0;
			target.addChild(thumb);
		}
		
		override public function uninstall():void
		{
			target.removeChild(thumb);
			target.removeChild(track);
			super.install();
		}
	}
}