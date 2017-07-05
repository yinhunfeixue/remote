package remote2.components
{
	import flash.geom.Point;
	
	import remote2.components.supports.SliderBase;
	import remote2.components.supports.SliderUtil;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 水平滑块 
	 * @author yinhunfeixue
	 * 
	 */	
	public class HSlider extends SliderBase
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function HSlider()
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