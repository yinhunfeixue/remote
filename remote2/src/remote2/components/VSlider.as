package remote2.components
{
	import flash.geom.Point;
	
	import remote2.components.supports.SliderBase;
	import remote2.components.supports.SliderUtil;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 竖直滑块 
	 * @author yinhunfeixue
	 * 
	 */	
	public class VSlider extends SliderBase
	{
		public function VSlider()
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