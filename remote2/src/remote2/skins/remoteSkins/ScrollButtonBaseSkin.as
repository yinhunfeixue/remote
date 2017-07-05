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
	internal class ScrollButtonBaseSkin extends RemoteSkin
	{	
		protected var points:Vector.<Point>;
		private var _borderColor:uint = 0x1B1B1B;
		private var _borderAlpha:Number = 0.3;
		
		public function ScrollButtonBaseSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.lineStyle(1, _borderColor, _borderAlpha);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			
			if(points != null && points.length > 0)
			{
				g.lineStyle(2, 0x999999);
				for (var i:int = 0; i < points.length; i++) 
				{
					if(i == 0)
						g.moveTo(points[i].x, points[i].y);
					else
						g.lineTo(points[i].x, points[i].y);
				}
			}
		}
		
	}
}