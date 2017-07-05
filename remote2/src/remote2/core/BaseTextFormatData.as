package remote2.core
{
	
	/**
	 * 存储文本基本格式的类
	 * 用于简化其它复杂类，比如按钮实现IBaseTextFormat接口
	 * 提供的fill方法可把数据填充到其它IBaseTextFormat实例中
	 * 文本组件的开发者可能需要使用此类
	 * @author 银魂飞雪
	 * @date 2013-5-11
	 * */
	public class BaseTextFormatData implements IBaseTextFormat
	{
		private var _color:* = null;
		private var _fontFamily:* = null;
		private var _bold:* = null;
		private var _italic:* = null;
		private var _fontSize:* = null;
		private var _align:* = null;
		private var _underline:* = null;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function BaseTextFormatData()
		{
		}
		
		/**
		 * 把属性填充到另一个 IBaseTextFormat对象中，只有设置过的属性才会填充
		 * @param target 目标对象
		 * 
		 */		
		public function fill(target:IBaseTextFormat):void
		{
			if(_color != null)
				target.color = color;
			if(_align != null)
				target.align = align;
			if(_bold != null)
				target.bold = bold;
			if(_fontFamily != null)
				target.fontFamily = fontFamily;
			if(_fontSize != null)
				target.fontSize = fontSize;
			if(_italic != null)
				target.italic = italic;
			if(_underline != null)
				target.underline = underline;
		}
		
		/**
		 * @inheritDoc
		 * 
		 */
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get fontFamily():String
		{
			return _fontFamily;
		}
		
		public function set fontFamily(value:String):void
		{
			_fontFamily = value;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get bold():Boolean
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_bold = value;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get italic():Boolean
		{
			return _italic;
		}
		
		public function set italic(value:Boolean):void
		{
			_italic = value;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get fontSize():Number
		{
			return _fontSize;
		}
		
		public function set fontSize(value:Number):void
		{
			_fontSize = value;
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get align():String
		{
			return _align;
		}
		
		public function set align(value:String):void
		{
			_align = value
		}
		/**
		 * @inheritDoc
		 * 
		 */
		public function get underline():Boolean
		{
			return _underline;
		}
		
		public function set underline(value:Boolean):void
		{
			_underline = value;
		}
	}
}