package remote2.sql
{
	import com.maclema.mysql.Connection;
	import com.maclema.mysql.MySqlResponse;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.ResultSet;
	import com.maclema.mysql.Statement;
	import com.maclema.mysql.events.MySqlErrorEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	import mx.rpc.AsyncResponder;
	
	import remote2.sql.events.SqlEvent;
	
	use namespace mx_internal;
	
	[Event(name="dataComplete", type="proxys.sql.events.SqlEvent")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	
	public class MYSQLExecuter extends EventDispatcher implements ISQLExecuter
	{
		
		private var _conn:Connection;
		
		private var _sqlText:String;
		
		private var _hostName:String;
		
		private var _port:int = 3306;
		
		private var _userName:String;
		
		private var _dataBase:String;
		
		private var _password:String;
		
		
		public function MYSQLExecuter(hostName:String, port:int, userName:String, password:String, dataBase:String = null)
		{
			_hostName = hostName;
			_port = port;
			_userName = userName;
			_password = password;
			_dataBase = dataBase;
		}
		
		public function get sqlText():String
		{
			return _sqlText;
		}
		
		public function excute(sqlText:String):void
		{
			_sqlText = sqlText;
			
			_conn = new Connection(_hostName, _port, _userName, _password, _dataBase);
			_conn.addEventListener(Event.CONNECT, conn_connectHandler);
			_conn.addEventListener(IOErrorEvent.IO_ERROR, conn_ioErrorHandler);
			_conn.addEventListener(MySqlErrorEvent.SQL_ERROR, conn_sqlErrorHandler);
			_conn.connect();
		}
		
		protected function conn_ioErrorHandler(event:IOErrorEvent):void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "网络连接失败 " + event.text));
		}
		
		protected function conn_sqlErrorHandler(event:MySqlErrorEvent):void
		{
			_conn.disconnect();
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.text));
		}
		
		public function test():Boolean
		{
			return true;
		}
		
		protected function conn_connectHandler(event:Event):void
		{
			_conn.removeEventListener(Event.CONNECT, conn_connectHandler);
			
			var sqlState:Statement = _conn.createStatement();
			
			var token:MySqlToken = sqlState.executeQuery(_sqlText);
			var responder:AsyncResponder = new AsyncResponder(resultResponder, faultResponder);
			token.addResponder(responder);
			
		}
		
		private function faultResponder(info:Object, token:Object):void 
		{
			_conn.disconnect();
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, info.toString()));
		}
		
		private function resultResponder(result:Object, token:Object):void
		{
			if(result is ResultSet)
			{
				var sqlState:ResultSet = result as ResultSet;
				var obj:* = (sqlState.getRows() as ArrayCollection).source;
				dispatchEvent(new SqlEvent(SqlEvent.DATA_COMPLETE, obj));
			}
			else
			{
				(result as MySqlResponse)
				dispatchEvent(new SqlEvent(SqlEvent.DATA_COMPLETE, result));
			}
			_conn.disconnect();
			
		}
	}
}