package remote2.formats
{

	/**
	 * 格式数字 
	 * @author yinhunfeixue
	 * 
	 */	
	public class NumberFormatter
	{

		/**
		 * 格式化数字，返回格式化后的字符串
		 * <br/>此方法使用数字替换字符串的低位，例如formatter(123, "abcdefg")返回abcd123
		 * @param number 数字
		 * @param formatStr 格式字符串
		 * @return 字符串
		 * 
		 */		
		public static function formatter(number:Number, formatStr:String):String
		{
			var numberStr:String = number.toString();
			if(numberStr.length > formatStr.length)
				return numberStr;
			else
				return formatStr.substr(0, formatStr.length - numberStr.length) + numberStr;
		}
	}
}