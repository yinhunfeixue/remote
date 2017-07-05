package remote2.components
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import remote2.components.supports.TextBase;
	import remote2.core.IBaseTextFormat;
	import remote2.core.remote_internal;
	import remote2.geom.Size;
	
	use namespace remote_internal;
	
	/**
	 * 纯文本标签 
	 * @author yinhunfeixue
	 * 
	 */	
	public class Label extends TextBase implements IBaseTextFormat
	{
		protected static var measureLabel:TextField;
		
		private var _textFormat:TextFormat;
		private var _textFormatChanged:Boolean;
		
		protected var displayLabel:TextField;
		
		private var _multiline:Boolean = false;
		private var _multilineChanged:Boolean;
		
		private var _wordWrap:Boolean = true;
		private var _wordWrapChanged:Boolean;
		
		public function Label()
		{
			super();
			selectable = false;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function measure():void
		{
			super.measure();
			
			var size:Size = measureTextSize();
			measuredWidth = size.width;
			measuredHeight = size.height;
		}
		
		private function measureTextSize():Size
		{
			if(measureLabel == null)
				measureLabel = new TextField();
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat(fontFamily, fontSize, color, bold, italic, underline);
			measureLabel.defaultTextFormat = tf;
			measureLabel.setTextFormat(tf);
			measureLabel.text = _text?_text:" ";
			measureLabel.width = isNaN(measureTextWidth)?10000:measureTextWidth;
			measureLabel.height = 10000;
			measureLabel.wordWrap = _multiline;
			measureLabel.multiline = _selectable;
			return new Size(measureLabel.textWidth + 5, measureLabel.textHeight + 4);
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			displayLabel = new TextField();
			displayLabel.type = TextFieldType.DYNAMIC;
			displayLabel.wordWrap = _wordWrap;
			displayLabel.autoSize = TextFieldAutoSize.NONE;
			displayLabel.multiline = _multiline;
			displayLabel.selectable = _selectable;
			displayLabel.addEventListener(Event.CHANGE, displayLabel_changeHandler);
			addChild(displayLabel);
		}
		
		protected function displayLabel_changeHandler(event:Event):void
		{
			text = displayLabel.text;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			displayLabel.width = unscaleWidth;
			displayLabel.height = unscaleHeight;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_textChanged)
			{
				_textChanged = false;
				displayLabel.text = _text;
			}
			if(_selectableChanged)
			{
				_selectableChanged = false;
				displayLabel.selectable = _selectable;
			}
			if(_textFormatChanged)
			{
				_textFormatChanged = false;
				displayLabel.defaultTextFormat = _textFormat;
				displayLabel.setTextFormat(_textFormat);
			}
			if(_displayAsPasswordChanged)
			{
				_displayAsPasswordChanged = false;
				displayLabel.displayAsPassword = _displayAsPassword;
			}
			if(_multilineChanged)
			{
				_multilineChanged = false;
				displayLabel.multiline = _multiline;
			}
			if(_wordWrapChanged)
			{
				_wordWrapChanged = false;
				displayLabel.wordWrap = _wordWrap;
			}
		}
		
		/**
		 * 是否多行 
		 * 
		 */		
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			if(_multiline != value)
			{
				_multiline = value;
				_multilineChanged = true;
				invalidateProperties();
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
		 * @inheritDoc 
		 * 
		 */	
		override public function set text(value:String):void
		{
			if(text != value)
			{
				super.text = value;
				invalidateProperties();
				invalidateSize();
			}
		}
		
		override public function set selectable(value:Boolean):void
		{
			if(_selectable != value)
			{
				super.selectable = value;
				invalidateProperties();
			}
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override public function set displayAsPassword(value:Boolean):void
		{
			if(displayAsPassword != value)
			{
				super.displayAsPassword = value;
				invalidateProperties();
			}
		}

		/**
		 * 文本格式 
		 * 
		 */		
		public function get textFormat():TextFormat
		{
			return _textFormat;
		}

		public function set textFormat(value:TextFormat):void
		{
			if(value == null)
				value = new TextFormat();
			_textFormat = value;
			_textFormatChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get align():String
		{
			return _textFormat?_textFormat.align:null;
		}
		
		public function set align(value:String):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.align = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get bold():Boolean
		{
			return _textFormat?_textFormat.bold:false;
		}
		
		public function set bold(value:Boolean):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.bold = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get color():uint
		{
			return _textFormat?_textFormat.color as uint:0x0;
		}
		
		public function set color(value:uint):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.color = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get fontFamily():String
		{
			return _textFormat?_textFormat.font:"null";
		}
		
		public function set fontFamily(value:String):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.font = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get fontSize():Number
		{
			return _textFormat?_textFormat.size as Number:12;
		}
		
		public function set fontSize(value:Number):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.size = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get italic():Boolean
		{
			return _textFormat?_textFormat.italic:false;
		}
		
		public function set italic(value:Boolean):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.italic = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		public function get underline():Boolean
		{
			return _textFormat?_textFormat.underline:false;
		}
		
		public function set underline(value:Boolean):void
		{
			var tf:TextFormat = _textFormat?_textFormat:new TextFormat();
			tf.underline = value;
			textFormat = tf;
		}
		
	}
}