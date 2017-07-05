package remote2
{
	import remote2.formats.NumberFormatter;

	/**
	 * 表示一个时间间隔 
	 * @author xjj.
	 * @date 2010-2-22.
	 */	
	public class TimeSpan
	{
		private const DAY_TO_HOUR:int = 24;
		private const HOUR_TO_MINUTE:int = 60;
		private const MINUTE_TO_SECOND:int = 60;
		private const SECOND_TO_MILLISECOND:int = 1000;
		
		private var _milliseconds:Number;
		
		/**
		 * 实例化TimeSpan.
		 * @param days 天数.
		 * @param hours 小时.
		 * @param minutes 分钟.
		 * @param seconds 秒数.
		 * @param milliseconds 毫秒.
		 */		
		public function TimeSpan(days:int = 0, hours:int = 0, minutes:int = 0, seconds:Number = 0, milliseconds:Number = 0)
		{
			_milliseconds = milliseconds;
			_milliseconds += seconds * SECOND_TO_MILLISECOND;
			_milliseconds += minutes * MINUTE_TO_SECOND * SECOND_TO_MILLISECOND;
			_milliseconds += hours * HOUR_TO_MINUTE * MINUTE_TO_SECOND * SECOND_TO_MILLISECOND;
			_milliseconds += days * DAY_TO_HOUR * HOUR_TO_MINUTE * MINUTE_TO_SECOND * SECOND_TO_MILLISECOND;
		}
		/**
		 * 此实例加上新的TimeSpan.
		 * @param ts TimeSpan.
		 * 
		 * @return 此实例的值与 ts 的值之和的新的 TimeSpan，不改变当前实例.
		 */		 
		public function add(ts:TimeSpan):TimeSpan
		{
			return new TimeSpan(0,0,0,0, _milliseconds + ts._milliseconds);
		}
		/**
		 * 返回新的 TimeSpan 对象，其值是当前 TimeSpan 对象的绝对值.
		 * @return 新的 TimeSpan，其值是当前 TimeSpan 对象的绝对值.
		 */
		public function abs():TimeSpan
		{
			return new TimeSpan(0,0,0,0, Math.abs(_milliseconds));
		}
		/**
		 * 获取由当前 TimeSpan 结构表示的整天数
		 */
		public function get days():int
		{
			if(_milliseconds >= 0)
				return Math.floor(totalDays);
			else
				return Math.ceil(totalDays);
		}
		/**
		 * 获取由当前 TimeSpan 结构表示的整小时数.
		 */
		public function get hours():int
		{
			if(_milliseconds >= 0)
				return Math.floor(totalHours) % DAY_TO_HOUR;
			else
				return Math.ceil(totalHours) % DAY_TO_HOUR;
		}
		/**
		 * 获取由当前 TimeSpan 结构表示的整分钟数.
		 */
		public function get minutes():int
		{
			if(_milliseconds >= 0)
				return Math.floor(totalMinutes) % HOUR_TO_MINUTE;
			else
				return Math.ceil(totalMinutes) % HOUR_TO_MINUTE;
		}
		/**
		 * 获取由当前 TimeSpan 结构表示的整秒数.
		 */
		public function get seconds():int
		{
			if(_milliseconds >= 0)
				return Math.floor(totalSeconds) % MINUTE_TO_SECOND;
			else
				return Math.ceil(totalSeconds) % MINUTE_TO_SECOND;
		}
		/**
		 * 获取由当前 TimeSpan 结构表示的整毫秒数.
		 */
		public function get milliseconds():int
		{
			if(_milliseconds >= 0)
				return Math.floor(_milliseconds) % SECOND_TO_MILLISECOND;
			else
				return Math.ceil(_milliseconds) % SECOND_TO_MILLISECOND;
		}
		/**
		 * 获取以整天数和天的小数部分表示的当前 TimeSpan 结构的值.
		 */
		public function get totalDays():Number
		{
			return totalHours / DAY_TO_HOUR;
		}
		/**
		 * 获取以整小时数和小时的小数部分表示的当前 TimeSpan 结构的值.
		 */
		public function get totalHours():Number
		{
			return totalMinutes / HOUR_TO_MINUTE;
		}
		/**
		 * 获取以整分钟数和分钟的小数部分表示的当前 TimeSpan 结构的值.
		 */
		public function get totalMinutes():Number
		{
			return totalSeconds / MINUTE_TO_SECOND;
		}
		/**
		 * 获取以整秒数和秒的小数部分表示的当前 TimeSpan 结构的值.
		 */
		public function get totalSeconds():Number
		{
			return _milliseconds / SECOND_TO_MILLISECOND;
		}
		/**
		 * 获取以整毫秒数和毫秒的小数部分表示的当前 TimeSpan 结构的值.
		 */
		public function get totalMilliseconds():Number
		{
			return _milliseconds;
		}
		
		
		/**
		 * 按指定格式格式化
		 * D——totalDays
		 * H——totalHours
		 * M——totalMinutes
		 * S——totalSeconds
		 * I——totalMilliseconds
		 * d——天
		 * h——时
		 * m——分
		 * s——秒
		 * i——毫秒
		 * 
		 * @param formatStr 格式字符串
		 * @return 格式化之后的字符串
		 * 
		 */		
		public function format(formatStr:String = "hh:mm:ss"):String
		{
			var o:Object = {
				"D":Math.floor(totalDays),
					"H":Math.floor(totalHours),
					"M":Math.floor(totalMinutes),
					"S":Math.floor(totalSeconds),
					"I":Math.floor(totalMilliseconds),
					"d":days,
					"h":hours,
					"m":minutes,
					"s":seconds,
					"i":milliseconds
			};
			var result:String = formatStr;
			for(var key:* in o)
			{
				result = result.replace(new RegExp("(" + key + "+)"), replaceFun);
				function replaceFun():String
				{
					var arg:* = arguments;
					var n:Number = o[key];
					var nstr:String = arg[1].replace(new RegExp(key, "g"), "0");
					
					return NumberFormatter.formatter(n, nstr);
				}
			}
			return result;
		}
	}
}