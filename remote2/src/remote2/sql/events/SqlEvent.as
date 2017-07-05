package remote2.sql.events
{
	import flash.events.Event;
	
	public class SqlEvent extends Event
	{
		public static const DATA_COMPLETE:String = "dataComplete";
		
		public var data:*;
		
		public function SqlEvent(type:String, data:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new SqlEvent(type, data, bubbles, cancelable);
		}
	}
}