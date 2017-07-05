package modules
{
	import remote2.components.ComboBox;
	import remote2.components.Label;
	import remote2.components.TextInput;
	import remote2.components.TitleWindow;
	
	
	/**
	 * 创建根组件的窗口
	 * 可设置：组件基类，类型名称，尺寸
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-9
	 *
	 * */
	public class CreateRootWindow extends TitleWindow
	{
		protected var inputType:TextInput;
		
		protected var inputWidth:TextInput;
		
		protected var inputHeight:TextInput;
		
		protected var comboboxSuper:ComboBox;
		
		public function CreateRootWindow()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var lbType:Label = new Label();
			lbType.text = "名称：";
			lbType.left = 10;
			addContent(lbType);
			
			inputType = new TextInput();
			inputType.prompt = "组件类型名称";
			inputType.left = 70;
			inputType.restrict = "a-zA-Z_   ";
			addContent(inputType);
		}
	}
}  