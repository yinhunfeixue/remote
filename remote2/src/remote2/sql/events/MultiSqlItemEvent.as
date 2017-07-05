package remote2.sql.events
{
	import flash.events.Event;
	
	public class MultiSqlItemEvent extends Event
	{
		public static const ITEM_COMPLETE:String = "itemComplete";
		
		/**
		 * 完成项对应的健，一般是SQL语句
		 */		
		public var key:String;
		
		/**
		 * 序号，顺序执行时，它表示当前项的序号；并发执行时，它表示在此项之前已执行完成的数量
		 */		
		public var index:int;
		
		/**
		 * 执行过程中产生的错误信息，如果没有发生错误，则为null
		 */		
		public var errorText:String;
		
		public function MultiSqlItemEvent(type:String, key:String, index:int, erroText:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.key = key;
			this.index = index;
			this.errorText = erroText;
		}
		
		override public function clone():Event
		{
			return new MultiSqlItemEvent(type, key, index, errorText, bubbles, cancelable);
		}
	}
}