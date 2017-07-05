package remote2.components
{
	import flash.events.FocusEvent;
	
	import remote2.components.supports.SkinnableTextBase;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 单行文本编辑器
	 *
	 * @author 银魂飞雪
	 * @date 2013-5-11
	 * */
	public class TextInput extends SkinnableTextBase
	{
		protected function get labelPrompt():Label
		{
			return findSkinPart("labelPrompt", false);
		}
		
		private var _prompt:String = "";
		private var _promptChanged:Boolean;
		
		private var _displayAsPassoword:Boolean;
		private var _displayAsPasswordChanged:Boolean;
		
		public function TextInput()
		{
			super();
		}
		
		private function textDisplay_focusOutHandler(event:FocusEvent):void
		{
			if(text == null || text.length == 0)
			{
				if(labelPrompt)
					labelPrompt.visible = true;
			}
		}
		
		private function textDisplay_focusInHandler(event:FocusEvent):void
		{
			if(labelPrompt)
				labelPrompt.visible = false;
		}
		
		override protected function commitProperties():void
		{
			var textChanged:Boolean = _textChanged;
			super.commitProperties();
			if(_displayAsPasswordChanged)
			{
				_displayAsPasswordChanged = false;
				textDisplay.displayAsPassword = true;
			}
			if(_promptChanged || textChanged)
			{
				if(_promptChanged)
					_promptChanged = false;
				changePrompt();
			}
		}
		
		private function changePrompt():void
		{
			if(labelPrompt)
			{
				labelPrompt.text = _prompt;
				if(text == null || text.length == 0)
					labelPrompt.visible = true;
				else
					labelPrompt.visible = false;
			}
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			if(textDisplay)
			{
				textDisplay.multiline = false;
				textDisplay.wordWrap = false;
				textDisplay.addEventListener(FocusEvent.FOCUS_IN, textDisplay_focusInHandler);
				textDisplay.addEventListener(FocusEvent.FOCUS_OUT, textDisplay_focusOutHandler);
			}
			if(labelPrompt)
			{
				labelPrompt.mouseEnabled = false;
				labelPrompt.mouseChildren = false;
			}
		}
		
		/**
		 * 是否以密码方式显示 
		 * 
		 */		
		public function get displayAsPassoword():Boolean
		{
			return _displayAsPassoword;
		}
		
		public function set displayAsPassoword(value:Boolean):void
		{
			if(_displayAsPassoword != value)
			{
				_displayAsPassoword = value;
				_displayAsPasswordChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * 文本为空时，显示的提示文字 
		 * 
		 */		
		public function get prompt():String
		{
			return _prompt;
		}
		
		public function set prompt(value:String):void
		{
			if(value == null)
				value = "";
			if(_prompt!= value)
			{
				_prompt = value;
				_promptChanged = true;
				invalidateProperties();
			}
		}
		
	}
}