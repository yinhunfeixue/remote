package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class HThumbSkin extends ThumbSkinBase
	{
		public function HThumbSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var center:Point = new Point(unscaleWidth / 2, unscaleHeight / 2);
			var interval:Number = 5;
			var g:Graphics = target.graphics;
			g.lineStyle(2, lineColor);
			g.moveTo(center.x, center.y - interval);
			g.lineTo(center.x, center.y + interval);
			
			g.moveTo(center.x - interval, center.y - interval);
			g.lineTo(center.x - interval, center.y + interval);
			
			g.moveTo(center.x + interval, center.y - interval);
			g.lineTo(center.x + interval, center.y + interval);
		}
	}
}