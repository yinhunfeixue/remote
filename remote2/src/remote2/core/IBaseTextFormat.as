package remote2.core
{

	/**
	 * 常用文本样式接口 
	 * @author yinhunfeixue
	 * 
	 */	
	public interface IBaseTextFormat
	{
		/**
		 * 颜色 
		 * 
		 */		
		function get color():uint;
		function set color(value:uint):void;
		
		/**
		 * 字体 
		 * 
		 */		
		function get fontFamily():String;
		function set fontFamily(value:String):void;
		
		/**
		 * 是否粗体 
		 * 
		 */		
		function get bold():Boolean;
		function set bold(value:Boolean):void;
		
		/**
		 * 是否斜体
		 * 
		 */		
		function get italic():Boolean;
		function set italic(value:Boolean):void;
		
		/**
		 * 字体大小 
		 * 
		 */		
		function get fontSize():Number;
		function set fontSize(value:Number):void;
		
		/**
		 * 水平对齐方式 
		 * @see lashx.textLayout.formats.TextAlign
		 */		
		function get align():String;
		function set align(value:String):void;
		
		
		/**
		 * 是否下划线 
		 * 
		 */		
		function get underline():Boolean;
		function set underline(value:Boolean):void;
		
	}
}