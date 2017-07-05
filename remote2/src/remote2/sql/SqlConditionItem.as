package remote2.sql
{
	import mx.utils.StringUtil;
	
	import remote2.utils.StringUtil2;
	

	/**
	 * 条件项，表示SQL中的一个条件,例如 name='123' 
	 * @author xujunjie
	 * 
	 */	
	public class SqlConditionItem extends SqlConditionBase
	{
		/**
		 * 参数，包含参数名称、运算符、使用{0}表示值所在的位置
		 * @example name = {0}
		 */		
		public var arg:String;
		
		/**
		 * 参数对应的值,如果值为空，则此条件将不会加入
		 * @example 123   '123'
		 */		
		public var value:String;

		/**
		 *  
		 * @param arg 参数，包含参数名称、运算符、使用{0}表示值所在的位置
		 * @param addType  * 连接方式 @see remote2.sql.ConditionItemTypeEnum
		 * @param value 参数对应的值,如果值为空，则此条件将不会加入
		 * 
		 */		
		public function SqlConditionItem(arg:String, addType:String, value:String = null)
		{
			this.arg = arg;
			this.addType = addType;
			this.value = value;
		}
		
		override public function toSqlString(useAddType:Boolean = true):String
		{
			if(isEffect)
			{
				var result:String = StringUtil.substitute(arg, value);
				if(useAddType)
					result = " " + addType + " " + result;
				return result;
			}
			return "";
		}
		
		override public function get isEffect():Boolean
		{
			return !StringUtil2.isEmpty(value);
		}
		
	}
}