package remote2.components
{
	import flash.geom.Point;
	
	import remote2.components.supports.ScrollBarBase;
	import remote2.components.supports.SliderUtil;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 竖直滚动条
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class VScrollBar extends ScrollBarBase
	{
		public function VScrollBar()
		{
			super();

		}
		
		/**
		 * @inheritDoc 
		 * 
		 */
		override protected function measure():void
		{
			measuredWidth = 20;
			measuredHeight = 100;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			var thumbSize:Number = track.height - maximum;
			if(isNaN(thumbSize) || thumbSize < 20)
				thumbSize = 20;
			if(thumbSize > unscaleHeight)
				thumbSize = unscaleHeight;
			thumb.height = thumbSize;
			super.updateDisplayList(unscaleWidth, unscaleHeight);

		}
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function pointToValue(point:Point):Number
		{
			return SliderUtil.verticalPointToValue(point, minimum, maximum, effectStepSize, track, thumb);
		}
		/**
		 * @inheritDoc 
		 * 
		 */
		override protected function valueToPoint():Point
		{
			return SliderUtil.verticalValueToPoint(value, minimum, maximum, track, thumb);
		}
	}
}