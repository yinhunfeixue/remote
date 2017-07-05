package remote2.sql
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import remote2.sql.events.MultiSqlItemEvent;
	import remote2.sql.events.SqlEvent;
	
	
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * 顺序执行多条语句 
	 * @author xujunjie
	 * 
	 */	
	public class SequentialSqlExecuter extends MultiSqlExecuter
	{
		
		//当前正在执行的SQL序号		
		protected var _currentIndex:int = -1;
		/**
		 *  
		 * @param sqlArray 要顺序执行的SQL语句
		 * 
		 */		
		public function SequentialSqlExecuter(sqlArray:Array, defaultCreater:Function, dicExecuter:Dictionary = null)
		{
			super(sqlArray, defaultCreater, dicExecuter);
		}
		
		/**
		 * 开始执行 
		 * 
		 */		
		override public function execute():void
		{
			_errorDic = new Dictionary();
			_resultDic = new Dictionary();
			if(_sqlArray != null && _sqlArray.length > 0)
			{
				execute2();
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function execute2():void
		{
			if(++_currentIndex < _sqlArray.length)
			{
				executeSql(_sqlArray[_currentIndex], onSqlResultHandler, onSqlErrorHandler);
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		private function getKey(index:int):*
		{
			return _sqlArray[index];
		}
		
		private function onSqlErrorHandler(event:ErrorEvent):void
		{
			_errorDic[getKey(_currentIndex)] = event.text;
			
			dispatchEvent(new MultiSqlItemEvent(MultiSqlItemEvent.ITEM_COMPLETE, getKey(_currentIndex), _currentIndex, event.text));
			
			execute2();
		}
		private function onSqlResultHandler(event:SqlEvent):void
		{
			_resultDic[getKey(_currentIndex)] = event.data;
			
			dispatchEvent(new MultiSqlItemEvent(MultiSqlItemEvent.ITEM_COMPLETE, getKey(_currentIndex), _currentIndex));
			
			execute2();
		}
	}
}