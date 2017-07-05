package remote2.sql
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import remote2.sql.events.MultiSqlItemEvent;
	import remote2.sql.events.SqlEvent;
	
	/**
	 * 并发执行多条SQL语句 
	 * @author xujunjie
	 * 
	 */	
	public class ConcurrentSqlExecuter extends MultiSqlExecuter
	{
		//执行完成的数量
		private var _completeCount:int = 0;
		
		public function ConcurrentSqlExecuter(sqlArray:Array, defaultCreater:Function, dicExecuter:Dictionary = null)
		{
			super(sqlArray, defaultCreater, dicExecuter);
		}
		
		override public function execute():void
		{
			_errorDic = new Dictionary();
			_resultDic = new Dictionary();
			if(_sqlArray != null && _sqlArray.length > 0)
			{
				for (var i:int = 0; i < _sqlArray.length; i++) 
				{
					executeSql(_sqlArray[i], sqlCompleteHandler, sqlErrorHandler);
				}
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function sqlErrorHandler(event:ErrorEvent):void
		{
			var target:ISQLExecuter = event.currentTarget as ISQLExecuter;
			
			_errorDic[target.sqlText] = event.text;
			
			dispatchEvent(new MultiSqlItemEvent(MultiSqlItemEvent.ITEM_COMPLETE, target.sqlText, _completeCount, event.text));
			
			checkIsComplete();
		}
		
		private function sqlCompleteHandler(event:SqlEvent):void
		{
			var target:ISQLExecuter = event.currentTarget as ISQLExecuter;
			
			_resultDic[target.sqlText] = event.data;
			
			dispatchEvent(new MultiSqlItemEvent(MultiSqlItemEvent.ITEM_COMPLETE, target.sqlText, _completeCount));
			
			checkIsComplete();
		}
		
		private function checkIsComplete():void
		{
			_completeCount++;
			if(_completeCount >= _sqlArray.length)
				dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}