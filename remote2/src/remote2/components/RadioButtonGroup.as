package remote2.components
{
	import flash.display3D.IndexBuffer3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 选中项改变事件 
	 */	
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * 单选按钮组 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RadioButtonGroup extends EventDispatcher
	{
		
		private var _radioButtonList:Vector.<RadioButton> = new Vector.<RadioButton>();
		
		private var _selection:RadioButton;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function RadioButtonGroup()
		{
			super();
		}
		
		remote_internal function addInstance(instance:RadioButton):void
		{
			if(instance == null)
				return;
			_radioButtonList.push(instance);
			if(_selection != null && instance.selected)
			{
				instance.selected = false;
			}
			if(instance.selected)
				setSelection(instance);
		}	
		
		remote_internal function removeInstance(instance:RadioButton):void
		{
			if(instance == null)
				return;
			var index:int = getInstanceIndex(instance);
			if(index >= 0)
			{
				_radioButtonList.splice(index, 1);
				if(instance == _selection)
				{
					_selection = null;
				}
			}
		}
		
		remote_internal function getInstanceIndex(instance:RadioButton):int
		{
			return _radioButtonList.indexOf(instance);
		}
		
		/**
		 * 设置选中项，只赋值 
		 * @param value
		 * 
		 */		
		remote_internal function setSelection(value:RadioButton):void
		{
			if(_selection != value)
			{
				_selection = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		/**
		 * 当前选中的单选按钮 
		 * 
		 */		
		public function get selection():RadioButton
		{
			return _selection;
		}
		
		public function set selection(value:RadioButton):void
		{
			if(getInstanceIndex(value) >= 0)
			{
				value.selected = true;
			}
		}
		
		/**
		 * 当前选中的值 
		 * 
		 */		
		public function set selectedValue(value:Object):void
		{
			for (var i:int = 0; i < _radioButtonList.length; i++) 
			{
				if(_radioButtonList[i].value == value)
				{
					_radioButtonList[i].selected = true;
					break;
				}
			}
		}
		
		public function get selectedValue():Object
		{
			if(!_selection)
				return null;
			return _selection.value;
		}
		
		/**
		 * 当前选中的序号 
		 * 
		 */		
		public function set selectedIndex(value:int):void
		{
			if(value >= 0 && value < _radioButtonList.length)
			{
				_radioButtonList[value].selected = true;
			}
		}
		
		public function get selectedIndex():int
		{
			if(_selection == null)
				return -1;
			return _radioButtonList.indexOf(_selection);
		}
		
	}
}