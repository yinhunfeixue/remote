package modules.setter
{
	import flashx.textLayout.formats.TextAlign;
	
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
	public class PositionSetter extends SetterBase
	{
		//变量声明
		protected var txtX:TextInput;
		protected var txtY:TextInput;
		private var txtWidth:TextInput;
		private var txtHeight:TextInput;
		
		public function PositionSetter()
		{
			super();
			title = "尺寸位置";
		}

		override protected function componentChanged():void
		{
			super.componentChanged();
			if(component)
			{
				txtX.text = component.x.toString();
				txtY.text = component.y.toString();
				txtWidth.text = component.width.toString();
				txtHeight.text = component.height.toString();
			}
			else
			{
				txtX.text = "";
				txtY.text = "";
				txtWidth.text = "";
				txtHeight.text = "";
			}
		}
		
		override protected function changeComponent():void
		{
			super.changeComponent();
			component.x = int(txtX.text);
			component.y = int(txtY.text);
			component.width = int(txtWidth.text);
			component.height = int(txtHeight.text);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			addDefaultLabels(["x：", "y：", "width：", "height："]);
			
			txtX = new TextInput();
			txtX.left = 65;
			txtX.y = 10;
			txtX.right = 10;
			txtX.height = 20;
			this.addContent(txtX);
			
			txtY = new TextInput();
			txtY.left = 65;
			txtY.right = 10;
			txtY.y = 40;
			txtY.height = 20;
			this.addContent(txtY);

			txtWidth = new TextInput();
			txtWidth.left = 65;
			txtWidth.y = 70;
			txtWidth.right = 10;
			txtWidth.height = 20;
			addContent(txtWidth);
			
			txtHeight = new TextInput();
			txtHeight.left = 65;
			txtHeight.y = 100;
			txtHeight.right = 10;
			txtHeight.height = 20;
			addContent(txtHeight);
			
		}
	}
}