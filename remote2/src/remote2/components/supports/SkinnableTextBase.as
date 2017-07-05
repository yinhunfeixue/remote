package remote2.components.supports
{
	import flashx.textLayout.elements.TextFlow;
	
	import remote2.components.RichText;
	import remote2.components.SkinnableComponent;
	import remote2.core.BaseTextFormatData;
	import remote2.core.IBaseTextFormat;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 有皮肤的文本基类
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-13
	 */	
	public class SkinnableTextBase extends SkinnableComponent implements IBaseTextFormat
	{
		protected function get textDisplay():RichText
		{
			return findSkinPart("textDisplay");
		}
		
		remote_internal var _text:String = "";
		remote_internal var _textChanged:Boolean;
		
		remote_internal var _textFlow:TextFlow;
		remote_internal var _textFlowChanged:Boolean;
		
		remote_internal var _baseTextFormat:BaseTextFormatData;
		private var _baseTextFormatChanged:Boolean;
		
		private var _restrict:String;
		private var _restrictChanged:Boolean;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function SkinnableTextBase()
		{
			super();
			_baseTextFormat = new BaseTextFormatData();
		}
		
		private function invalidateBaseTextFormat():void
		{
			_baseTextFormatChanged = true;
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_textChanged)
			{
				_textChanged = false;
				textDisplay.text = _text;
			}
			if(_textFlowChanged)
			{
				_textFlowChanged = false;
				textDisplay.textflow = _textFlow;
			}
			if(_baseTextFormatChanged)
			{
				_baseTextFormatChanged = false;
				_baseTextFormat.fill(textDisplay);
			}
			if(_restrictChanged)
			{
				_restrictChanged = false;
				textDisplay.restrict = _restrict;
			}
		}
		
		/**
		 * 设置文字内容 
		 * 
		 */		
		public function get text():String
		{
			if(textDisplay)
				return textDisplay.text;
			return _text;
		}
		
		public function set text(value:String):void
		{
			if(textDisplay)
				textDisplay.text = value;
			else
			{
				_text = value;
				_textChanged = true;
			}
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		public function get align():String
		{
			return _baseTextFormat.align;
		}
		
		public function set align(value:String):void
		{
			_baseTextFormat.align = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get bold():Boolean
		{
			return _baseTextFormat.bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_baseTextFormat.bold = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get color():uint
		{
			return _baseTextFormat.color;
		}
		
		public function set color(value:uint):void
		{
			_baseTextFormat.color = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontFamily():String
		{
			return _baseTextFormat.fontFamily;
		}
		
		public function set fontFamily(value:String):void
		{
			_baseTextFormat.fontFamily = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontSize():Number
		{
			return _baseTextFormat.fontSize;
		}
		
		public function set fontSize(value:Number):void
		{
			_baseTextFormat.fontSize = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get italic():Boolean
		{
			return _baseTextFormat.italic;
		}
		
		public function set italic(value:Boolean):void
		{
			_baseTextFormat.italic = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get underline():Boolean
		{
			return _baseTextFormat.underline;
		}
		
		public function set underline(value:Boolean):void
		{
			_baseTextFormat.underline = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get textFlow():TextFlow
		{
			return _textFlow;
		}

		public function set textFlow(value:TextFlow):void
		{
			_textFlow = value;
			_textFlowChanged = true;
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		public function get restrict():String
		{
			return _restrict;
		}

		public function set restrict(value:String):void
		{
			_restrict = value;
			_restrictChanged = true;
			invalidateProperties();
		}


	}
}