package remote2.utils
{
	

	/**
	 * 数字辅助类 
	 * @author yinhunfeixue
	 * 
	 */	
	public class NumberUtil
	{
		/**
		 * 判定两个数字是否相等，与==不同，此方法将两个NaN视作相同的数字 
		 * @param n1 数字1
		 * @param n2 数字2
		 * @return 两个数字是否相等
		 * 
		 */		
		public static function equal(n1:Number, n2:Number):Boolean
		{
			if(n1 == n2)
				return true;
			if(isNaN(n1) && isNaN(n2))
				return true;
			return false;
		}
		
		public static function format(number:Number, formatString:String):String
		{
			var numberStr:String = number.toString();
			return formatString.substr(0, formatString.length - numberStr.length) + numberStr;
		}
		
		/**
		 * 判断一个字符串是否是合法的数字字符串
		 * @param str 
		 * @return 
		 * 
		 */		
		public static function stringIsNumber(str:String):Boolean
		{
			return !isNaN(Number(str));
		}
	}
}