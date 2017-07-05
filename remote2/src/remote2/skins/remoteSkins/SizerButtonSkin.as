package remote2.skins.remoteSkins
{
	import flash.display.Graphics;

	/**
	 * 
	 *
	 * @author xujunjie
	 * @date 2013-5-26 下午5:58:23
	 * 
	 */	
	public class SizerButtonSkin extends RemoteSkin
	{
		public function SizerButtonSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.lineStyle(1, 0x000055);
			g.drawRect(-3, -3, 6, 6);
			g.endFill();
		}
		
	}
}