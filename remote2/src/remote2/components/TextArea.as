package remote2.components
{
	import flash.events.FocusEvent;
	
	import remote2.components.supports.SkinnableTextBase;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 文本编辑器，支持多行
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-13
	 */	
	public class TextArea extends SkinnableTextBase
	{
		protected function get labelPrompt():Label
		{
			return findSkinPart("labelPrompt", false);
		}
		
		private var _wordWrap:Boolean = true;
		private var _wordWrapChanged:Boolean;
		
		private var _prompt:String = "";
		private var _promptChanged:Boolean;
		
		public function TextArea()
		{
			super();
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			if(textDisplay)
			{
				textDisplay.multiline = true;
				textDisplay.wordWrap = _wordWrap;
				textDisplay.addEventListener(FocusEvent.FOCUS_IN, textDisplay_focusInHandler);
				textDisplay.addEventListener(FocusEvent.FOCUS_OUT, textDisplay_focusOutHandler);
			}
			if(labelPrompt)
			{
				labelPrompt.mouseEnabled = false;
				labelPrompt.mouseChildren = false;
			}
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
			if(_wordWrapChanged)
			{
				_wordWrapChanged = false;
				textDisplay.wordWrap = _wordWrap;
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
		
		/**
		 * 是否自动换行 
		 * 
		 */		
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			if(_wordWrap != value)
			{
				_wordWrap = value;
				_wordWrapChanged = true;
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