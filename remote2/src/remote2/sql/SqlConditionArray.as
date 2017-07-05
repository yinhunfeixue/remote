package remote2.sql
{
	import remote2.utils.StringUtil2;
	
	public class SqlConditionArray extends SqlConditionBase
	{
		public var itemArray:Array;
		
		public function SqlConditionArray(itemArray:Array, addType:String = "")
		{
			this.addType = addType;
			this.itemArray = itemArray;
		}
		
		override public function toSqlString(useAddType:Boolean = true):String
		{
			var item:SqlConditionBase;
			var isFirst:Boolean = true;
			var result:String = "";
			
			for (var i:int = 0; i < itemArray.length; i++) 
			{
				item = itemArray[i];
				if(item.isEffect)
				{
					result += item.toSqlString(!isFirst);
					if(isFirst)
						isFirst = false;
				}
			}
			if(!StringUtil2.isEmpty(result))
			{
				result = "(" + result + ")";
				if(useAddType)
					result = " " + addType + " " + result;
			}
			return result;
		}
		
		override public function get isEffect():Boolean
		{
			if(itemArray == null)
				return false;
			else
			{
				for (var i:int = 0; i < itemArray.length; i++) 
				{
					if((itemArray[i] as SqlConditionBase).isEffect == true)
						return true;
				}
				return false;
			}
		}
	}
}