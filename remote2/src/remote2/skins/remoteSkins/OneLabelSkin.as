package remote2.skins.remoteSkins
{
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	import remote2.components.Label;
	import remote2.components.RichText;
	
	/**
	 * 有一个文本框的皮肤 
	 * @author yinhunfeixue
	 * 
	 */	
	internal class OneLabelSkin extends RemoteSkin
	{
		private var _labelDisplay:RichText;
		
		public function get labelDisplay():RichText
		{
			if(_labelDisplay == null)
			{
				createLabel();
			}
			return _labelDisplay;
		}
		
		public function OneLabelSkin()
		{
			super();
		}
		
		protected function createLabel():void
		{
			_labelDisplay = new RichText();
			_labelDisplay.left = 10;
			_labelDisplay.right = 10;
			_labelDisplay.top = 4;
			_labelDisplay.bottom = 4;
			_labelDisplay.fontFamily = defaultFont;
			_labelDisplay.align = TextAlign.CENTER;
			_labelDisplay.verticalAlign = VerticalAlign.MIDDLE;
			target.addChild(_labelDisplay);
		}
		
		override public function uninstall():void
		{
			if(_labelDisplay)
				target.removeChild(_labelDisplay);
			super.uninstall();
		}
	}
}