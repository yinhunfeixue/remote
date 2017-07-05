package modules.setter
{
	import flash.events.KeyboardEvent;
	
	import remote2.components.Label;
	import remote2.components.SkinnableComponent;
	import remote2.components.TextInput;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class NameSetter extends SetterBase
	{
		private var txtName:TextInput;
		private var txtStyle:TextInput;
		
		
		public function NameSetter()
		{
			super();
			title = "名称设置";
		}
		
		override protected function componentChanged():void
		{
			super.componentChanged();
			if(component)
			{
				txtName.text = component.name;
				if(component is SkinnableComponent)
				{
					txtStyle.text = (component as SkinnableComponent).styleName;
					txtStyle.enabled = true;
				}
				else
				{
					txtStyle.text = "";
					txtStyle.enabled = false;
				}
			}
			else
			{
				txtName.text = "";
				txtStyle.text = "";
			}
			
		}
		
		override protected function changeComponent():void
		{
			super.changeComponent();
			if(component)
			{
				component.name = txtName.text;
				if(component is SkinnableComponent)
				{
					(component as SkinnableComponent).styleName = txtStyle.text;
				}
			}
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addDefaultLabels(["名称：", "样式："]);
			
			txtName = new TextInput();
			txtName.y = 10;
			txtName.left = 65;
			txtName.right = 10;
			addContent(txtName);
			
			
			txtStyle = new TextInput();
			txtStyle.y = 40;
			txtStyle.left = 65;
			txtStyle.right = 10;
			addContent(txtStyle);
		}
		
		protected function txtName_keyDownHandler(event:KeyboardEvent):void
		{
			
		}
		
		
	}
}