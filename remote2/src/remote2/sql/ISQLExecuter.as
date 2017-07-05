package remote2.sql
{
	import flash.events.IEventDispatcher;

	[Event(name="dataComplete", type="proxys.sql.events.SqlEvent")]
	
	public interface ISQLExecuter extends IEventDispatcher
	{
		/**
		 * 执行SQL语句 
		 * @param sqlText
		 * 
		 */		
		function excute(sqlText:String):void;
		
		/**
		 * 当前执行的SQL语句 
		 * 
		 */		
		function get sqlText():String;
		
		/**
		 * 测试连接是否可用 
		 * @return 
		 * 
		 */		
		function test():Boolean;
	}
}