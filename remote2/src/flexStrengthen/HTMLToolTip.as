package flexStrengthen
{
	import mx.controls.ToolTip;
	
	public class HTMLToolTip extends ToolTip
	{

		private var _textChanged:Boolean;
		public function HTMLToolTip()
		{
			super();
		}
		
		override public function set text(value:String):void
		{
			super.text = value;
			_textChanged = true;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			
			super.commitProperties();
			
			if (_textChanged)
			{
				textField.htmlText = text;
				_textChanged = false;
			}
		}
	}
}