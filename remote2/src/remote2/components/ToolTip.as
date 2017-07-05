package remote2.components
{
	import remote2.core.IDisplayText;
	import remote2.core.IToolTip;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 提示控件
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-3
	 */	
	public class ToolTip extends SkinnableComponent implements IToolTip
	{
		public static var maxWidth:Number = 300;
		
		private function get textDisplay():IDisplayText
		{
			return findSkinPart("textDisplay");
		}
		
		private var _text:String;
		private var _textChanged:Boolean;
		
		public function ToolTip()
		{
			super();
			mouseEnabled = false;
			mouseChildren = false;
			includeInLayout = false;
		}
		
		override protected function measure():void
		{
			super.measure();
			if(measuredWidth > maxWidth)
				measuredWidth = maxWidth;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_textChanged)
			{
				_textChanged = false;
				textDisplay.text = _text;
			}
		}
		
		public function get isTruncated():Boolean
		{
			return false;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			_textChanged = true;
			invalidateProperties();
		}
		
		public function get text():String
		{
			return null;
		}
		
	}
}