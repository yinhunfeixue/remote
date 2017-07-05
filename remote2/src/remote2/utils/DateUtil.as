package remote2.utils
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;
	
	import remote2.TimeSpan;
	
	/**
	 * 日期辅助类
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class DateUtil
	{
		/**
		 * 格式化日期
		 * 
		 * @param date 日期
		 * @param pattern 格式化字符串
		 * @return 格式化后的字符串
		 * 
		 * @see  flash.globalization.DateTimeFormatter#setDateTimePattern()
		 */		
		public static function format(date:Date, pattern:String = "yyyy-MM-dd HH:mm:ss"):String
		{
			var formatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
			formatter.setDateTimePattern(pattern);
			return formatter.format(date);
		}
		
		public static function subDate(date:Date, addTimeSpan:TimeSpan):Date
		{
			return new Date(date.time + addTimeSpan.totalMilliseconds);
		}
		
		/**
		 * 获取某年某月最大的日期值，31，30或者28中的一个 
		 * @param year
		 * @param month 0——11
		 * @return 
		 * 
		 */		
		public static function getMaxDate(year:Number, month:Number):int
		{
			month = month + 1
			switch(month)
			{
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					return 31;
				case 4:
				case 6:
				case 9:
				case 11:
					return 30;
				case 2:
					return isLeapYear(year)?29:28;
				default:
					throw new Error("month mush between 1--12");
					return 0;
			}
		}
		
		/**
		 * 指定年份是否是闰年 
		 * @param year
		 * @return 
		 * 
		 */		
		public static function isLeapYear(year:Number):Boolean
		{
			return year % 400 == 0 || (year % 100 != 0 && year % 4 == 0);
		}
	}
}