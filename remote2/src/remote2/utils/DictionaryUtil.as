package remote2.utils
{
	import flash.utils.Dictionary;

	public class DictionaryUtil
	{
		/**
		 * 获取字典中键的数量 
		 * @param dic
		 * @return 
		 * 
		 */		
		public static function getLength(dic:Dictionary):int
		{
			if(dic == null)
				return 0;
			
			var result:int = 0;
			for(var key:* in dic)
			{
				result++;
			}
			return result;
		}
		
		
		public static function toArray(dic:Dictionary):Array
		{
			if(dic == null)
				return null;
			
			var result:Array = [];
			for each(var item:* in dic)
			{
				result.push(item);
			}
			return result;
		}
	}
}