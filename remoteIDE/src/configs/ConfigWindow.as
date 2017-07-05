package configs
{
	import configs.init.Init;
	
	import flash.events.MouseEvent;
	
	import remote2.components.Button;
	import remote2.components.TextInput;
	import remote2.manager.PopUpManager;
	
	import modules.setter.SetterBase;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-6
	 *
	 * */
	public class ConfigWindow extends SetterBase
	{
		protected var textInputName:TextInput;
		protected var buttonSave:Button;
		
		public function ConfigWindow()
		{
			super();
			width = 500;
			height = 500;
			isPopup = true;
			title = "系统设置";
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addDefaultLabels(["用户名："]);
			
			textInputName = new TextInput();
			textInputName.y = 10;
			textInputName.left = 65;
			textInputName.right = 10;
			addContent(textInputName);
			
			buttonSave = new Button();
			buttonSave.addEventListener(MouseEvent.CLICK, buttonSave_clickHandler);
			buttonSave.label = "保存";
			buttonSave.bottom = 10;
			buttonSave.horizontalCenter = 0;
			addContent(buttonSave);
		}
		
		protected function buttonSave_clickHandler(event:MouseEvent):void
		{
			if(textInputName.text.length > 0)
			{
				Init.userName = textInputName.text;
				Init.save();
				PopUpManager.removePopUp(this);
			}
			else
			{
				
			}
		}
	}
}