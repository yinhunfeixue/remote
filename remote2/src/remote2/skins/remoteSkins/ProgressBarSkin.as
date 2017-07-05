package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	import remote2.components.ProgressBar;

	public class ProgressBarSkin extends RemoteSkin
	{
		private var _barColor:uint = 0x8B9194;
		
		public function ProgressBarSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var progressBar:ProgressBar = target as ProgressBar;
			
			var g:Graphics = target.graphics;
			g.beginFill(_barColor);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
			
			g.beginFill(themeColor);
			g.drawRect(0, 0, unscaleWidth * progressBar.value / progressBar.maxValue, unscaleHeight);
			g.endFill();
			
		}
	}
}