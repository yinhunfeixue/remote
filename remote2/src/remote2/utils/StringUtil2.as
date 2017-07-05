package remote2.utils
{
	import flash.utils.ByteArray;
	
	import mx.utils.StringUtil;
	
	public class StringUtil2
	{
		/**
		 * 字符串是否为空 
		 * @param str 字符串
		 * @return 如果为null, 长度为0，
		 * 
		 */		
		public static function isEmpty(str:String):Boolean
		{
			return str == null || str.length == 0 || mx.utils.StringUtil.isWhitespace(str);
		}
		
		public static function defaultString(str:String, defaultStr:String = ""):String
		{
			return str != null?str:defaultStr;
		}
		
		public static function transCharSet(str:String, inCode:String, outCode:String):String
		{
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, inCode);
			byte.position = 0;
			return byte.readMultiByte(byte.length, outCode);
		}
		
		public static function transCharSetCode(str:String, code:String):String
		{
			var result:String = "";
			
			for (var i:int = 0; i < str.length; i++) 
			{
				var byte:ByteArray = new ByteArray();
				byte.writeMultiByte(str.charAt(i), code);
				
				if(byte.length > 1)
				{	
					for (var j:int = 0; j < byte.length; j++) 
					{
						result += escape(String.fromCharCode(byte[j]));
					}
				}
				else
					result += str.charAt(i);
			}
			return result;
		}
		
		public static function getFirstWord(str:String):String
		{
			var result:String = "";
			for(var i:int = 0; i < str.length; i++)
			{
				var byteArray:ByteArray = new ByteArray();
				byteArray.writeMultiByte(str.charAt(i), "gb2312");
				
				var code:int = (byteArray[0]<<8) + byteArray[1];
				if (code>=45217 && code<=45252) 
				{ 
					result += "A"; 
				} 
				else if(code>=45253 && code<=45760) 
				{ 
					result += "B"; 
				} 
				else if(code>=45761 && code<=46317) 
				{ 
					result += "C"; 
				} 
				else if(code>=46318 && code<=46825) 
				{ 
					result += "D"; 
				} 
				else if(code>=46826 && code<=47009) 
				{ 
					result += "E"; 
				} 
				else if(code>=47010 && code<=47296) 
				{ 
					result += "F"; 
				} 
				else if(code>=47297 && code<=47613) 
				{ 
					result += "G"; 
				} 
				else if(code>=47614 && code<=48118) 
				{ 
					result += "H"; 
				} 
				else if(code>=48119 && code<=49061) 
				{ 
					result += "J"; 
				} 
				else if(code>=49062 && code<=49323) 
				{ 
					result += "K"; 
				} 
				else if(code>=49324 && code<=49895) 
				{ 
					result += "L"; 
				} 
				else if(code>=49896 && code<=50370) 
				{ 
					result += "M"; 
				} 
					
				else if(code>=50371 && code<=50613) 
				{ 
					result += "N"; 
				} 
				else if(code>=50614 && code<=50621) 
				{ 
					result += "O"; 
				} 
				else if(code>=50622 && code<=50905) 
				{ 
					result += "P"; 
				} 
				else if(code>=50906 && code<=51386) 
				{ 
					result += "Q"; 
				} 
				else if(code>=51387 && code<=51445) 
				{ 
					result += "R"; 
				} 
				else if(code>=51446 && code<=52217) 
				{ 
					result += "S"; 
				} 
				else if(code>=52218 && code<=52697) 
				{ 
					result += "T"; 
				} 
				else if(code>=52698 && code<=52979) 
				{ 
					result += "W"; 
				} 
				else if(code>=52980 && code<=53688) 
				{ 
					result += "X"; 
				} 
				else if(code>=53689 && code<=54480) 
				{ 
					result += "Y"; 
				} 
				else if(code>=54481 && code<=55289) 
				{ 
					result += "Z"; 
				} 
				else 
					result += str.charAt(i); 
			}
			return result;
		}
		
	}
}