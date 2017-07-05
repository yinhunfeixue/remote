package remote2.sql
{
	internal class SqlConditionBase
	{
		
		/**
		 * 连接方式
		 * @see remote2.sql.ConditionItemTypeEnum
		 */		
		public var addType:String;
		
		public function SqlConditionBase()
		{
		}
		
		public function toSqlString(useAddType:Boolean = true):String
		{
			return "";
		}
		
		public function get isEffect():Boolean
		{
			return false;
		}
	}
}