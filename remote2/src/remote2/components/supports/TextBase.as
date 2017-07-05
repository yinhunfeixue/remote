package remote2.components.supports
{
	import remote2.core.IDisplayText;
	import remote2.core.remote_internal;
	import remote2.utils.NumberUtil;
	
	use namespace remote_internal;
	/**
	 * 文本显示基类，只用于显示，不用于编辑 
	 * @author yinhunfeixue
	 * 
	 */	
	public class TextBase extends LayoutComponent implements IDisplayText
	{
		/**
		 * 是否截断 
		 */		
		remote_internal var _isTruncated:Boolean = false;
		remote_internal var _isTruncatedChanged:Boolean;
		
		/**
		 * 最大显示行数 
		 */		
		remote_internal var _maxDisplayedLines:int = 0;
		remote_internal var _maxDisplayedLinesChanged:Boolean;
		
		/**
		 * 文本 
		 */		
		remote_internal var _text:String;
		remote_internal var _textChanged:Boolean;
		
		remote_internal var _selectable:Boolean = false;
		remote_internal var _selectableChanged:Boolean;
		
		remote_internal var _displayAsPassword:Boolean;
		remote_internal var _displayAsPasswordChanged:Boolean;
		
		private var _layoutWidth:Number;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function TextBase()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get isTruncated():Boolean
		{
			return _isTruncated;
		}
		
		/**
		 * 最大行数 
		 */
		public function get maxDisplayedLines():int
		{
			return _maxDisplayedLines;
		}
		
		/**
		 * @private
		 */
		public function set maxDisplayedLines(value:int):void
		{
			_maxDisplayedLines = value;
		}
		
		/**
		 * 文本内容 
		 */
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * @private
		 */
		public function set text(value:String):void
		{
			if(value == null)
				value = "";
			if(_text != value)
			{
				_text = value;
				_textChanged = true;
			}
		}
		
		/**
		 * 文字是否可选 
		 * 
		 */
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		public function set selectable(value:Boolean):void
		{
			if(_selectable != value)
			{
				_selectable = value;
				_selectableChanged = true;
			}
		}
		
		/**
		 * 是否显示为密码 
		 */
		public function get displayAsPassword():Boolean
		{
			return _displayAsPassword;
		}
		
		/**
		 * @private
		 */
		public function set displayAsPassword(value:Boolean):void
		{
			if(_displayAsPassword != value)
			{
				_displayAsPassword = value;
				_displayAsPasswordChanged = true;
			}
		}
		
		override public function setLayoutSize(width:Number, height:Number):void
		{
			super.setLayoutSize(width, height);
			if(!NumberUtil.equal(_layoutWidth, width))
			{
				_layoutWidth = width;
				invalidateSize();
			}
		}
		
		protected function get measureTextWidth():Number
		{
			return isNaN(explicitWidth)?_layoutWidth:explicitWidth;
		}
		
		
	}
}