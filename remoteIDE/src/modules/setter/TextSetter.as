package modules.setter
{
	import remote2.components.TextArea;
	import remote2.components.TextInput;
	import remote2.core.IDisplayLabel;
	import remote2.core.IDisplayText;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-7-4
	 *
	 * */
	public class TextSetter extends SetterBase
	{
		protected var txtText:TextArea;
		
		public function TextSetter()
		{
			super();
			title = "文字";
		}
		
		override protected function changeComponent():void
		{
			super.changeComponent();
			if(component is IDisplayText)
			{
				(component as IDisplayText).text = txtText.text;
			}
			if(component is IDisplayLabel)
			{
				(component as IDisplayLabel).label = txtText.text;
			}
		}
		
		override protected function componentChanged():void
		{
			super.componentChanged();
			if(component is IDisplayText)
			{
				txtText.text = (component as IDisplayText).text;
				visible = true;
				includeInLayout = true;
			}
			else if(component is IDisplayLabel)
			{
				txtText.text = (component as IDisplayLabel).label;
				visible = true;
				includeInLayout = true;
			}
			else
			{
				txtText.text = "";
				visible = false;
				includeInLayout = false;
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addDefaultLabels(["内容："]);
			txtText = new TextArea();
			txtText.percentWidth = 100;
			txtText.height = 100;
			txtText.y = 30;
			addContent(txtText);
		}
	}
}