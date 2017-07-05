package remote2.sql
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import remote2.sql.events.SqlEvent;
	import remote2.utils.DictionaryUtil;
	import remote2.utils.EventUtil;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="itemComplete", type="proxys.sql.events.MultiSqlItemEvent")]
	
	/**
	 * 多条SQL执行 
	 * @author xujunjie
	 * 
	 */	
	public class MultiSqlExecuter extends EventDispatcher
	{
		
		//要执行的SQL语句 	
		protected var _sqlArray:Array;
		
		protected var _resultDic:Dictionary;
		
		protected var _errorDic:Dictionary;
		
		//SQL执行器列表
		protected var _dicExecuter:Dictionary;
		
			
		protected var _defaultCreater:Function;
		
		/**
		 *  
		 * @param sqlArray SQL语句列表
		 * @param executer 执行器键值对，键为sqlArray中对应的SQL语句，值为ISQLExecuter实例。如果所有项都使用默认执行器，则设置为null即可，如果某一项为特殊执行器，则此项设置对应值，其它项不需要设置
		 * 
		 * 默认执行器为SQLCreater.createExecuter()
		 * 
		 */		
		public function MultiSqlExecuter(sqlArray:Array, defaultCreater:Function, dicExecuter:Dictionary = null)
		{
			_sqlArray = sqlArray;
			_defaultCreater = defaultCreater;
			_dicExecuter = dicExecuter;
		}
		
		/**
		 * 通过SQL语句，获取执行的结果 
		 * @param sql SQL语句
		 * @return 执行的结果
		 * 
		 */		
		public function getResult(key:String):*
		{
			if(_resultDic!= null)
				return _resultDic[key];
			return null;
		}
		
		/**
		 * 获取执行时发生的错误，如果无错误，则返回null
		 * @param key
		 * @return 错误信息
		 * 
		 */		
		public function getError(key:String):String
		{
			if(_errorDic != null)
				return _errorDic[key];
			return null;
		}
		
		public function execute():void
		{
			
		}
		/**
		 * 执行SQL语句，执行成功后，触发指定的方法
		 * 方法只会触发一次，无需手动移除事件监听
		 * @param sql SQL语句
		 * @param completeHandler 执行成功后，触发的方法
		 * @param errorHandler 执行出错后，触发的方法
		 * @return 
		 * 
		 */		
		protected function executeSql(sql:String, completeHandler:Function, errorHandler:Function):ISQLExecuter
		{
			var result:ISQLExecuter;
			if(_dicExecuter == null || _dicExecuter[sql] == null)
				result = _defaultCreater();
			else
				result = _dicExecuter[sql];
			EventUtil.addOnceEventListener(result, SqlEvent.DATA_COMPLETE, completeHandler);
			EventUtil.addOnceEventListener(result, ErrorEvent.ERROR, errorHandler);
			result.excute(sql);
			return result;
		}
		
		public function get sqlArray():Array
		{
			return _sqlArray;
		}
		
		public function get hasError():Boolean
		{
			return DictionaryUtil.getLength(_errorDic) > 0;
		}
		
		/**
		 * 执行结果 
		 */
		public function get resultDic():Dictionary
		{
			return _resultDic;
		}
		
		/**
		 * 执行时发生的错误信息 
		 */
		public function get errorDic():Dictionary
		{
			return _errorDic;
		}
	}
}