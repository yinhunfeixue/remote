package remote2.components
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 富文本编辑器 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RichEditableText extends RichText
	{
		private var _editable:Boolean;
		private var _editableChanged:Boolean;
		
		private var _enbaleChanged:Boolean;

		
		public function RichEditableText()
		{
			super();
			editable = true;
		}
		/**
		 * @inheritDoc
		 */	
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_enbaleChanged = true;
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			textDisplay.addEventListener(KeyboardEvent.KEY_DOWN, textChangeHandler);
			textDisplay.addEventListener(TextEvent.TEXT_INPUT, textChangeHandler);
			textDisplay.multiline = true;
		}
		
		protected function textChangeHandler(event:Event):void
		{
			invalidateSize();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_editableChanged || _enbaleChanged)
			{
				_editableChanged = false;
				_enbaleChanged = false;
				if(enabled)
					textDisplay.type = _editable?TextFieldType.INPUT:TextFieldType.DYNAMIC;
				else
					textDisplay.type = TextFieldType.DYNAMIC;
			}
			if(_displayAsPasswordChanged)
			{
				_displayAsPasswordChanged = false;
				textDisplay.displayAsPassword = _displayAsPassword;
			}
		}
		/**
		 * @inheritDoc
		 */	
		override public function get text():String
		{
			if(textDisplay && textDisplay.text)
				return textDisplay.text;
			return super.text;
		}
		
		/**
		 * 是否可编辑 
		 */
		public function get editable():Boolean
		{
			return _editable;
		}
		
		/**
		 * @private
		 */
		public function set editable(value:Boolean):void
		{
			_editable = value;
			_editableChanged = true;
			invalidateProperties();
		}
		

		
		
	}
}