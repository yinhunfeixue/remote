package remote2.components
{
	import flash.geom.Point;
	
	import remote2.components.supports.ScrollBarBase;
	import remote2.components.supports.SliderUtil;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 水平滚动条
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class HScrollBar extends ScrollBarBase
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function HScrollBar()
		{
			super();
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function measure():void
		{
			measuredWidth = 100;
			measuredHeight = 20;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			var thumbSize:Number = track.width - maximum;
			if(isNaN(thumbSize) || thumbSize < 20)
				thumbSize = 20;
			if(thumbSize > unscaleWidth)
				thumbSize = unscaleWidth;
			thumb.width = thumbSize;
			super.updateDisplayList(unscaleWidth, unscaleHeight);
		}
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function pointToValue(point:Point):Number
		{
			return SliderUtil.horizontalPointToValue(point, minimum, maximum, effectStepSize, track, thumb);
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function valueToPoint():Point
		{
			return SliderUtil.horizontalValueToPoint(value, minimum, maximum, track, thumb);
		}
	}
}