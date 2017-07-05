package remote2.components.supports
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * 滑块辅助类，提供了滑块位置和鼠标位置转换的方法
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class SliderUtil
	{
		public static function horizontalPointToValue(point:Point, minimum:Number, maximum:Number, stepSize:Number,  track:DisplayObject, thumb:DisplayObject):Number
		{
			var value:Number = 0;
			var effectWidth:Number = track.width;
			if(thumb)
			{
				effectWidth = track.width - thumb.width;
			}
			if(point == null || effectWidth <= 0)						//如果点为空，或者真实的轨道宽度小于等于0，直接返回0
				value = 0;
			if(point.x <= 0)
				value = minimum;
			else if(point.x >= effectWidth)
				value = maximum;
			else
			{
				value = minimum + (maximum - minimum) * point.x / effectWidth;
				if(stepSize > 0)
					value = Math.round(value / stepSize) * stepSize;
			}
			return value;
		}
		
		public static function horizontalValueToPoint(value:Number, minimum:Number, maximum:Number, track:DisplayObject, thumb:DisplayObject):Point
		{
			var result:Point = new Point(0, 0);
			var effectWidth:Number = track.width;
			if(thumb)
			{
				result.y = thumb.y;
				effectWidth = track.width - thumb.width;
			}
			result.x = track.x + (value - minimum) / (maximum - minimum) * effectWidth;
			return result;
		}
		
		public static function verticalPointToValue(point:Point, minimum:Number, maximum:Number, stepSize:Number,  track:DisplayObject, thumb:DisplayObject):Number
		{
			var value:Number = 0;
			var effectHeight:Number = track.height;
			if(thumb)
			{
				effectHeight = track.height - thumb.height;
			}
			if(point == null || effectHeight <= 0)						//如果点为空，或者真实的轨道宽度小于等于0，直接返回0
				value = 0;
			if(point.y <= 0)
				value = minimum;
			else if(point.y >= effectHeight)
				value = maximum;
			else
			{
				value = minimum + (maximum - minimum) * point.y / effectHeight;
				if(stepSize > 0)
					value = Math.round(value / stepSize) * stepSize;
			}
			return value;
		}
		
		public static function verticalValueToPoint(value:Number, minimum:Number, maximum:Number, track:DisplayObject, thumb:DisplayObject):Point
		{
			var result:Point = new Point(0, 0);
			var effectHeight:Number = track.height;
			if(thumb)
			{
				result.y = thumb.y;
				effectHeight = track.height - thumb.height;
			}
			result.y = track.y + (value - minimum) / (maximum - minimum) * effectHeight;
			return result;
		}
	}
}