package remote2.utils
{
	public class ArrayUtil
	{
		public static function convertEach(array:Array, fun:Function):Array
		{
			var result:Array = [];
			if(array != null)
			{
				for (var i:int = 0; i < array.length; i++) 
				{
					var item:* = fun(array[i]);
					result.push(item);
				}
			}
			return result;
		}
		
		
		public static function searchItemIndexByProperty(array:Array, propertyName:String, propertyValue:*):*
		{
			if(array == null)
				return -1;
			for (var i:int = 0; i < array.length; i++) 
			{
				var item:Object = array[i];
				if(item != null && item.hasOwnProperty(propertyName) && item[propertyName] == propertyValue)
					return i;
			}
			return -1;			
		}
	}
}