package remote2.skins.remoteSkins
{
	import flash.geom.Point;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class VIncrementButtonSkin extends ScrollButtonBaseSkin
	{
		public function VIncrementButtonSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			var center:Point = new Point(unscaleWidth / 2, unscaleHeight / 2);
			
			points = new Vector.<Point>();
			points.push(new Point(center.x - 3, center.y - 2), new Point(center.x, center.y + 2), new Point(center.x + 3, center.y - 2));
			
			super.updateDisplayList(unscaleWidth, unscaleHeight);
		}
	}
}