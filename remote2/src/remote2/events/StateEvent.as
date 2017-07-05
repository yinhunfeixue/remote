package remote2.events
{
	import flash.events.Event;
	
	/**
	 * 状态改变事件 
	 * @author yinhunfeixue
	 * 
	 */	
	public class StateEvent extends Event
	{
		public static const STATE_CHANGED:String = "stateChnanged";
		
		/**
		 * 新状态 
		 */		
		public var newState:String;
		
		/**
		 * 旧状态 
		 */		
		public var oldState:String;
		
		public function StateEvent(type:String,  newState:String, oldState:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.newState = newState;
			this.oldState = oldState;
		}
		
		override public function clone():Event
		{
			return new StateEvent(type, newState, oldState, bubbles, cancelable);
		}
	}
}