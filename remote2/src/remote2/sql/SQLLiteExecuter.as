package remote2.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import remote2.sql.events.SqlEvent;
	import remote2.sql.ISQLExecuter;
	
	[Event(name="dataComplete", type="proxys.sql.events.SqlEvent")]

	internal class SQLLiteExecuter extends EventDispatcher implements ISQLExecuter
	{
		private var _conn:SQLConnection;
		
		private var _sqlText:String;
		
		private var _file:File;
		
		public function SQLLiteExecuter(file:File)
		{
			_file = file;
		}
		
		public function get sqlText():String
		{
			return _sqlText;
		}

		public function excute(sqlText:String):void
		{
			_sqlText = sqlText;
			
			_conn = new SQLConnection();
			_conn.addEventListener(SQLEvent.OPEN, conn_openHandler);
			_conn.open(_file);
		}
		
		/**
		 * 测试是否是数据库文件  
		 * @param file
		 * @return 
		 * 
		 */		
		public function test():Boolean
		{
			var conn:SQLConnection = new SQLConnection();
			try
			{
				conn.open(_file);
			} 
			catch(error:Error) 
			{
				return false;
			}
			return true;
		}
		
		protected function conn_openHandler(event:Event):void
		{
			_conn.removeEventListener(SQLEvent.OPEN, conn_openHandler);
			
			var sqlState:SQLStatement = new SQLStatement();
			sqlState.addEventListener(SQLEvent.RESULT, sqlState_resultHandler);
			sqlState.sqlConnection = _conn;
			sqlState.text = _sqlText;
			sqlState.execute();
		}
		
		protected function sqlState_resultHandler(event:SQLEvent):void
		{
			var sqlState:SQLStatement = event.currentTarget as SQLStatement;
			var data:Array = sqlState.getResult().data;
			
			_conn.close();
			
			dispatchEvent(new SqlEvent(SqlEvent.DATA_COMPLETE, data));
		}
	}
}