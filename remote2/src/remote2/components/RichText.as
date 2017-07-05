package remote2.components
{
	import fl.text.TLFTextField;
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.TextLayoutEvent;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import remote2.components.supports.TextBase;
	import remote2.core.IBaseTextFormat;
	import remote2.core.IViewport;
	import remote2.core.remote_internal;
	import remote2.events.ScrollEvent;
	import remote2.geom.Size;
	
	use namespace remote_internal;
	/**
	 * 富文本组件
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-10
	 */	
	public class RichText extends TextBase implements IBaseTextFormat, IViewport
	{
		protected static var measureLabel:TLFTextField;
		
		protected var textDisplay:TLFTextField;
		
		/**
		 * 记录从外部赋的值 
		 */		
		private var _textflow:TextFlow;
		private var _textflowChanged:Boolean;
		
		private var _textFormat:TextLayoutFormat;
		private var _textFormatChanged:Boolean;
		
		private var _multiline:Boolean = true;
		private var _multilineChanged:Boolean;
		
		private var _wordWrap:Boolean = true;
		private var _wordWrapChanged:Boolean;
		
		private var _hscrollValue:Number = 0;
		private var _hscrollValueChanged:Boolean;
		private var _vscrollValue:Number = 1;
		private var _vscrollValueChanged:Boolean;
		private var _maxhscrollValue:Number = 0;
		private var _maxvscrollValue:Number = 0;
		
		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		private var _paddingLeft:Number;
		private var _paddingRight:Number;
		private var _paddingChanged:Boolean;
		
		private var _restrict:String;
		private var _restrictChanged:Boolean;
		
		
		/**
		 * 实例化 
		 * 
		 */		
		public function RichText()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			textDisplay = new TLFTextField();
			textDisplay.paddingTop = 0;
			textDisplay.paddingLeft = 0;
			textDisplay.paddingBottom = 0;
			textDisplay.paddingRight = 0;
			textDisplay.autoSize = TextFieldAutoSize.NONE;
			textDisplay.wordWrap = true;
			textDisplay.type = TextFieldType.DYNAMIC;
			textDisplay.addEventListener(Event.SCROLL, textDisplay_scrollHandler);
			addChild(textDisplay);
		}
		
		private function setHorizontalScrollValue(value:Number):void
		{
			if(value < 1)
				value = 1;
			if(value > maxHScrollValue)
				value = maxHScrollValue;
			if(_hscrollValue != value)
			{
				_hscrollValue = value;
				dispatchEvent(new ScrollEvent(ScrollEvent.HORIZONTAL_VALUE_CHANGED, _hscrollValue));
			}
		}
		
		private function setVerticalScrollValue(value:Number):void
		{
			if(value < 1)
				value = 1;
			if(value > maxVScrollValue)
				value = maxVScrollValue;
			if(_vscrollValue != value)
			{
				_vscrollValue = value;
				dispatchEvent(new ScrollEvent(ScrollEvent.VERTICAL_VALUE_CHANGED, _vscrollValue));
			}
		}
		
		protected function textDisplay_scrollHandler(event:Event):void
		{
			setHorizontalScrollValue(textDisplay.controller.horizontalScrollPosition);
			setVerticalScrollValue(textDisplay.controller.verticalScrollPosition);
		}
		
		private function measureTextSize():Size
		{
			if(measureLabel == null)
				measureLabel = new TLFTextField();
			measureLabel.defaultTextFormat = _textFormat?hostFormatToTextFormat():new TextFormat();
			if(_textflow)
				measureLabel.textFlow = _textflow;
			else
				measureLabel.text = text?text:" ";
			measureLabel.paddingTop = _paddingTop;
			measureLabel.paddingBottom = _paddingBottom;
			measureLabel.paddingLeft = _paddingLeft;
			measureLabel.paddingRight = _paddingRight;
			measureLabel.wordWrap = _wordWrap;
			measureLabel.multiline = _multiline;
			measureLabel.width =isNaN(measureTextWidth)?10000:measureTextWidth;
			measureLabel.height = 10000;
			return new Size(measureLabel.textWidth, measureLabel.textHeight);
		}
		
		override protected function measure():void
		{
			super.measure();
			var size:Size = measureTextSize();
			measuredWidth = size.width;
			measuredHeight = size.height;
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			textDisplay.width = unscaleWidth;
			textDisplay.height = unscaleHeight;
			textDisplay.removeEventListener(Event.SCROLL, textDisplay_scrollHandler);
			if(textDisplay.controller)
			{
				textDisplay.controller.horizontalScrollPosition = _hscrollValue;
				textDisplay.controller.verticalScrollPosition = _vscrollValue;
			}
			textDisplay.addEventListener(Event.SCROLL, textDisplay_scrollHandler);
			if(textDisplay.maxScrollH != _maxhscrollValue)
			{
				_maxhscrollValue = textDisplay.maxScrollH;
				dispatchEvent(new ScrollEvent(ScrollEvent.MAX_HORIZONTAL_VALUE_CHANGED, _maxhscrollValue));
			}
			if(textDisplay.maxScrollV != _maxvscrollValue)
			{
				_maxvscrollValue = textDisplay.maxScrollV;
				dispatchEvent(new ScrollEvent(ScrollEvent.MAX_VERTICAL_VALUE_CHANGED, _maxvscrollValue));
			}
		}
		
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_textChanged)
			{
				_textChanged = false;
				textDisplay.text = _text;
			}
			if(_textflowChanged)
			{
				_textflowChanged = false;
				if(_textflow != null)
				{
					_textflow.format = _textFormat;
				}
				textDisplay.textFlow = _textflow;
			}
			if(_selectableChanged)
			{
				_selectableChanged = false;
				textDisplay.selectable = _selectable;
			}
			if(_textFormatChanged)
			{
				_textFormatChanged = false;
				if(_textflow != null)
					_textflow.format = _textFormat;
				if(textDisplay.textFlow)
					textDisplay.textFlow.format = _textFormat;
				textDisplay.defaultTextFormat = hostFormatToTextFormat();
				textDisplay.setTextFormat(hostFormatToTextFormat());
				textDisplay.verticalAlign = _textFormat.verticalAlign;
			}
			if(_multilineChanged)
			{
				_multilineChanged = false;
				textDisplay.multiline = _multiline;
			}
			if(_wordWrapChanged)
			{
				_wordWrapChanged = false;
				textDisplay.wordWrap = _wordWrap;
			}
			if(_vscrollValueChanged)
			{
				_vscrollValueChanged = false;
				if(textDisplay.controller)
					textDisplay.controller.verticalScrollPosition = _vscrollValue;
			}
			if(_hscrollValueChanged)
			{
				_hscrollValueChanged = false;
				if(textDisplay.controller)
					textDisplay.controller.horizontalScrollPosition = _hscrollValue;
			}
			if(_paddingChanged)
			{
				_paddingChanged = false;
				textDisplay.paddingTop = _paddingTop;
				textDisplay.paddingBottom = _paddingBottom;
				textDisplay.paddingLeft = _paddingLeft;
				textDisplay.paddingRight = _paddingRight;
			}
			if(_restrictChanged)
			{
				_restrictChanged = false;
				textDisplay.restrict = _restrict;
			}
		}
		
		private function hostFormatToTextFormat():TextFormat
		{
			if(_textFormat != null)
			{
				var result:TextFormat = new TextFormat();
				result.color = _textFormat.color;
				result.align = _textFormat.textAlign;
				result.bold = _textFormat.fontWeight == FontWeight.BOLD;
				result.italic = _textFormat.fontStyle == FontPosture.ITALIC;
				result.font = _textFormat.fontFamily;
				result.size = _textFormat.fontSize;
				result.underline = _textFormat.textDecoration == TextDecoration.UNDERLINE;
				return result;
			}
			return null;
		}
		/**
		 * @inheritDoc
		 */	
		override public function get text():String
		{
			if(textDisplay)
				return textDisplay.text;
			return super.text;
		}
		
		override public function set text(value:String):void
		{
			if(textDisplay)
				textDisplay.text = value;
			else
			{
				super.text = value;
				_textflowChanged = false;
			}
			invalidateProperties();
			invalidateSize();
		}
		
		/**
		 * 富文本块 
		 * 
		 */		
		public function get textflow():TextFlow
		{
			if(textDisplay)
				return textDisplay.textFlow;
			return _textflow;
		}
		
		public function set textflow(value:TextFlow):void
		{
			if(textDisplay)
				textDisplay.textFlow = value;
			else
			{
				_textflow = value;
				_textflowChanged = true;
				
				_textChanged = false;
			}
			invalidateProperties();
			invalidateSize();
		}
		/**
		 * @inheritDoc
		 */	
		override public function set selectable(value:Boolean):void
		{
			_selectable = value;
			_selectableChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 文本格式 
		 * @return 
		 * 
		 */		
		public function get textFormat():TextLayoutFormat
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextLayoutFormat):void
		{
			_textFormat = value;
			_textFormatChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 是否允许多行 
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
		 * 竖直对齐方式 
		 * 
		 * @see flashx.textLayout.formats.VerticalAlign
		 */		
		public function get verticalAlign():String
		{
			return _textFormat?_textFormat.verticalAlign:null;
		}
		
		public function set verticalAlign(value:String):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.verticalAlign = value;
			textFormat = tf;
		}
		//textFormat
		/**
		 * @inheritDoc
		 */	
		public function get align():String
		{
			return _textFormat?_textFormat.textAlign:null;
		}
		
		public function set align(value:String):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.textAlign = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get bold():Boolean
		{
			return _textFormat?_textFormat.fontWeight == FontWeight.BOLD:false;
		}
		
		public function set bold(value:Boolean):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.fontWeight = value?FontWeight.BOLD:FontWeight.NORMAL;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get color():uint
		{
			return _textFormat?_textFormat.color:0x0;
		}
		
		public function set color(value:uint):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.color = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontFamily():String
		{
			return _textFormat?_textFormat.fontFamily:null;
		}
		
		public function set fontFamily(value:String):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.fontFamily = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontSize():Number
		{
			return _textFormat?_textFormat.fontSize:12;
		}
		
		public function set fontSize(value:Number):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.fontSize = value;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get italic():Boolean
		{
			return _textFormat?_textFormat.fontStyle == FontPosture.ITALIC:false;
		}
		
		public function set italic(value:Boolean):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.fontStyle = value?FontPosture.ITALIC:FontPosture.NORMAL;
			textFormat = tf;
		}
		/**
		 * @inheritDoc
		 */	
		public function get underline():Boolean
		{
			return _textFormat?_textFormat.textDecoration == TextDecoration.UNDERLINE:false;
		}
		
		public function set underline(value:Boolean):void
		{
			var tf:TextLayoutFormat = _textFormat?_textFormat:new TextLayoutFormat();
			tf.textDecoration = value?TextDecoration.UNDERLINE:TextDecoration.NONE;
			textFormat = tf;
		}

		
		//iviewPort
		/**
		 * @inheritDoc
		 */	
		public function get contentHeight():Number
		{
			if(textDisplay)
			{
				return textDisplay.textHeight;
			}
			return height;
		}
		
		public function get contentWidth():Number
		{
			if(textDisplay)
				return textDisplay.textWidth;
			return width;
		}
		/**
		 * @inheritDoc
		 */	
		public function get horizontalScrollValue():Number
		{
			return _hscrollValue;
		}
		
		public function set horizontalScrollValue(value:Number):void
		{
			setHorizontalScrollValue(value);
			_hscrollValueChanged = true;
			invalidateProperties();
		}
		/**
		 * @inheritDoc
		 */	
		public function get horizontalSpeed():Number
		{
			return 0;
		}
		/**
		 * @inheritDoc
		 */	
		public function get verticalScrollValue():Number
		{
			return _vscrollValue;
		}
		
		public function set verticalScrollValue(value:Number):void
		{
			if(value != _vscrollValue)
			{
				setVerticalScrollValue(value);
				_vscrollValueChanged = true;
				invalidateProperties();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get verticalSpeed():Number
		{
			return 0;
		}
		/**
		 * @inheritDoc
		 */	
		public function get maxHScrollValue():Number
		{
			if(textDisplay && textDisplay.controller)
				return Math.max(0, textDisplay.controller.getContentBounds().right - width);
			return 0;
		}
		
		public function get maxVScrollValue():Number
		{
			if(textDisplay && textDisplay.controller)
				return Math.max(0, textDisplay.controller.getContentBounds().bottom - height) ;
			return 0;
		}
		
		
		//PADDING
		
		/**
		 * 文字距离顶端的距离 
		 * 
		 */		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
			_paddingChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		
		/**
		 * 文字距离底端的距离 
		 * 
		 */	
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
			_paddingChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		
		/**
		 * 文字距离左边的距离 
		 * 
		 */	
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
			_paddingChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		
		/**
		 * 文字距离右边的距离 
		 * 
		 */	
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
			_paddingChanged = true;
			invalidateProperties();
			invalidateSize();
		}
		
		/**
		 * 文本限制
		 * 
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