package remote2.components
{
	import flash.events.MouseEvent;
	
	import remote2.components.supports.ToggleButtonBase;
	import remote2.core.remote_internal;
	
	
	use namespace remote_internal;
	/**
	 * 单选按钮
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class RadioButton extends ToggleButtonBase
	{
		private var _value:Object;
		
		private var _group:RadioButtonGroup;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function RadioButton()
		{
			super();
		}
		
		override protected function mouseEventHandler(event:MouseEvent):void
		{
			super.mouseEventHandler(event);
			if(event.type == MouseEvent.CLICK)
			{
				if(enabled && !selected)
					selected = true;
			}
		}
		
		/**
		 * 只修改组件本身的选中，不处理group
		 * @param value 是否选中
		 * 
		 */		
		remote_internal function setSelected(value:Boolean):void
		{
			super.selected = value;
		}
		/**
		 * @inheritDoc
		 */	
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			if(_group)
			{
				if(selected)
				{
					if(_group.selection && _group.selection != this)
						_group.selection.setSelected(false);
					_group.setSelection(this);
				}
				else if(_group.selection == this)
				{
					_group.setSelection(null);
				}
			}
		}
		
		/**
		 *   与 RadioButton 组件关联的可选用户定义值。
		 */
		public function get value():Object
		{
			return _value;
		}
		
		/**
		 * @private
		 */
		public function set value(value:Object):void
		{
			_value = value;
		}
		
		/**
		 * 此 RadioButton 所属的 RadioButtonGroup 组件。创建要放入 RadioButtonGroup 中的 RadioButton 时，应该对所有按钮使用 group 属性 
		 */
		public function get group():RadioButtonGroup
		{
			return _group;
		}
		
		/**
		 * @private
		 */
		public function set group(value:RadioButtonGroup):void
		{
			if(_group)
				_group.removeInstance(this);
			_group = value;
			if(_group)
				_group.addInstance(this);
		}
		
		
	}
}