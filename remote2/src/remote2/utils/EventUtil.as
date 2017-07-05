package remote2.utils
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class EventUtil
	{
		public static function addOnceEventListener(target:IEventDispatcher, eventType:String, eventFunction:Function):void
		{
			target.addEventListener(eventType, doFunction);
			
			function doFunction(event:Event):void
			{
				if(eventFunction != null)
					eventFunction(event);
				target.removeEventListener(eventType, doFunction);
			}
		}
	}
}