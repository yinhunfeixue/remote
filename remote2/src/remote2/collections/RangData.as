package remote2.collections
{
	/**
	 * 区间数据模型 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RangData
	{
		/**
		 * 最小值 
		 */		
		public var minimum:Number;
		
		/**
		 * 最大值 
		 */		
		public var maximum:Number;
		
		/**
		 * 当前值 
		 */		
		public var value:Number;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function RangData()
		{
		}
		
		/**
		 * 校正数据，需要手动调用
		 * 
		 */		
		public function adjust():void
		{
			if(isNaN(value))
				value = 0;
			if(isNaN(maximum))
				maximum = 0;
			if(isNaN(minimum))
				minimum = 0;
			if(minimum > maximum)
				minimum = maximum;
			if(value > maximum)
				value = maximum;
			if(value < minimum)
				value = minimum;
		}
	}
}