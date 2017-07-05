package remote2.skins.remoteSkins
{
	import flash.geom.Point;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class HIncrementButtonSkin extends ScrollButtonBaseSkin
	{
		public function HIncrementButtonSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			var center:Point = new Point(unscaleWidth / 2, unscaleHeight / 2);
			
			points = new Vector.<Point>();
			points.push(new Point(center.x - 2, center.y - 3), new Point(center.x + 2, center.y), new Point(center.x - 2, center.y + 3));
			
			super.updateDisplayList(unscaleWidth, unscaleHeight);
		}
	}
}