package remote2.components.supports
{
	import flash.events.Event;
	
	import remote2.core.remote_internal;

	use namespace remote_internal;
	
	[SkinState("upAndSelected")]
	
	[SkinState("overAndSelected")]
	
	[SkinState("downAndSelected")]
	
	[SkinState("disabledAndSelected")]
	
	[Event(name="change", type="flash.events.Event")]
	/**
	 * 切换按钮基类
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class ToggleButtonBase extends ButtonBase
	{
		private var _selected:Boolean;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ToggleButtonBase()
		{
			super();
			buttonMode = true;
		}
		
		override protected function getCurrentState():String
		{
			var result:String = super.getCurrentState();
			if(selected)
			{
				result = result + "AndSelected";
			}
			return result;
		}
		
		/**
		 * 是否选中
		 * 
		 */		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				dispatchEvent(new Event(Event.CHANGE));
				validateSkinState();
			}
		}
		
	}
}