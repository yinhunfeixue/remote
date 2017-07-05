package modules.setter
{
	import remote2.components.SkinnableComponent;
	import remote2.components.UIComponent;
	import remote2.layouts.VerticalLayout;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class SetterPanel extends SkinnableComponent
	{
		
		private var _component:UIComponent;
		
		private var _setterArr:Array = [];
		
		public function SetterPanel()
		{
			super();
			
			layout = new VerticalLayout();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var nameSetter:NameSetter = new NameSetter();
			_setterArr.push(nameSetter);
			addChild(nameSetter);
			
			var positonSetter:PositionSetter = new PositionSetter();
			_setterArr.push(positonSetter);
			addChild(positonSetter);
			
			var textSetter:TextSetter = new TextSetter();
			_setterArr.push(textSetter);
			addChild(textSetter);
			
			var layoutSetter:LayoutSetter = new LayoutSetter();
			_setterArr.push(layoutSetter);
			addChild(layoutSetter);
		}
		
		public function get component():UIComponent
		{
			return _component;
		}
		
		public function set component(value:UIComponent):void
		{
			_component = value;
			for each (var item:SetterBase in _setterArr) 
			{
				item.component = value;
			}
			
		}
		
	}
}