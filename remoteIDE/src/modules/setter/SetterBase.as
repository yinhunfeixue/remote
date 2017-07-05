package modules.setter
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormatAlign;
	
	import remote2.components.Label;
	import remote2.components.TitleWindow;
	import remote2.components.UIComponent;
	
	import skins.PaddingTitleWindowSkin;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class SetterBase extends TitleWindow
	{
		
		private var _component:UIComponent;
		private var _componentChanged:Boolean;
		
		public function SetterBase()
		{
			super();
			addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			percentWidth = 100;
			skinClass = PaddingTitleWindowSkin;
			closeControlEnable = false;
			sizeControlEnable = false;
		}
		
		protected function addDefaultLabels(textArr:Array):void
		{
			for (var i:int = 0; i < textArr.length; i++) 
			{
				var label:Label = new Label();
				label.selectable = true;
				label.fontFamily = "Simsun";
				label.fontSize = 12;
				label.color = 0x000000;
				label.width = 60;
				label.y = 10 + i * 30;
				label.align = TextFormatAlign.RIGHT;
				label.text = textArr[i];
				addContent(label);
			}
		}
		
		protected function focusOutHandler(event:FocusEvent):void
		{
			if(component)
				changeComponent();
		}
		
		protected function keyUpHandler(event:KeyboardEvent):void
		{
			if(component)
				changeComponent();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_componentChanged)
			{
				_componentChanged = false;
				componentChanged();
			}
		}
		
		protected function changeComponent():void
		{
			
		}
		
		protected function componentChanged():void
		{
			
		}
		
		public function get component():UIComponent
		{
			return _component;
		}
		
		public function set component(value:UIComponent):void
		{
			_component = value;
			_componentChanged = true;
			invalidateProperties();
		}
	}
}