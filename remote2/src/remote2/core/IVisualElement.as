package remote2.core
{
	import flash.display.DisplayObject;

	/**
	 * 定义可视元素的接口 
	 * @author银魂飞雪
	 * @date 2013-4-13
	 * 
	 */	
	public interface IVisualElement
	{
		/**
		 * 对象的宽度 
		 * 
		 */		
		function get width():Number;
		function set width(value:Number):void;
		
		/**
		 * 对象的高度 
		 * 
		 */		
		function get height():Number;
		function set height(value:Number):void;
		
		/**
		 * 相对父元素的水平坐标 
		 * 
		 */		
		function get x():Number;
		function set x(value:Number):void;
		
		/**
		 * 相对父元素的竖直坐标 
		 * 
		 */		
		function get y():Number;
		function set y(value:Number):void;
		
		/**
		 * 表示指定对象的 Alpha 透明度值。有效值为 0（完全透明）到 1（完全不透明）。默认值为 1。alpha 设置为 0 的显示对象是活动的，即使它们不可见。 
		 * 
		 */		
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		/**
		 * 控制此可视元素的可见性。如果为 true，则对象可见。 
		 * 
		 */		
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		/**
		 * 此 IVisualElement 对象的逻辑所有者，默认为父容器 
		 * 
		 */		
		function get owner():DisplayObject;
		function set owner(value:DisplayObject):void;
		
		
		
		/**
		 * 显示深度
		 * 确定容器内各项目的呈示顺序。根据项目的 depth 属性确定这些项目的顺序，具有最低深度的项目在后面，具有较高深度的项目在前面。具有相同深度值的项目按照添加到容器中的顺序显示。
		 * 
		 */		
		function get depth():Number;
		function set depth(value:Number):void;

	}
}