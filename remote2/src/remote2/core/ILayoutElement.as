package remote2.core
{
	import flash.media.Video;

	/**
	 * 定义布局需要的接口 
	 * @author银魂飞雪
	 * @date 2013-4-13
	 * 
	 */	
	public interface ILayoutElement extends IVisualElement
	{
		
		/**
		 * 设置布局尺寸 
		 * @param width
		 * @param height
		 * 
		 */		
		function setLayoutSize(width:Number, height:Number):void;
		
		/**
		 * 从组件的左边缘到锚点目标的左边缘的水平距离（以像素为单位）。 
		 * 
		 */		
		function get left():Number;
		
		function set left(value:Number):void;
		
		/**
		 * 从组件的右边缘到锚点目标的右边缘的水平距离（以像素为单位）。 
		 * 
		 */		
		function get right():Number;
		
		function set right(value:Number):void;
		
		/**
		 * 从组件的右边缘到锚点目标的右边缘的水平距离（以像素为单位）。  
		 * 
		 */		
		function get top():Number;
		
		function set top(value:Number):void;
		
		/**
		 * 从组件的右边缘到锚点目标的右边缘的水平距离（以像素为单位）。  
		 * 
		 */		
		function get bottom():Number;
		
		function set bottom(value:Number):void;
		
		/**
		 * 从组件中心到锚点目标的内容区域中心的水平距离（以像素为单位）。  
		 * 
		 */		
		function get horizontalCenter():Number;
		
		function set horizontalCenter(value:Number):void;
		
		/**
		 * 从组件中心到锚点目标的内容区域中心的垂直距离（以像素为单位）。 
		 * 
		 */		
		function get verticalCenter():Number;
		
		function set verticalCenter(value:Number):void;
		
		/**
		 * 以组件父代大小百分比的方式指定组件宽度。允许的值为 0-100。设置 width 或 explicitWidth 属性会将此属性重置为 NaN。 
		 * 
		 */		
		function get percentWidth():Number;
		
		function set percentWidth(value:Number):void;
		
		/**
		 * 以组件父代大小百分比的方式指定组件高度。允许的值为 0-100。设置 height 或 explicitHeight 属性会将此属性重置为 NaN。  
		 * 
		 */		
		function get percentHeight():Number;
		
		function set percentHeight(value:Number):void;
		
		/**
		 * 指定此组件是否包含在父容器的布局中。如果为 true，则该对象将包含在其父容器的布局中，并由其父容器根据其布局规则调整其大小并确定其位置。如果为 false，则对象的父容器的布局不影响该对象的大小和位置。 
		 * 
		 */		
		function get includeInLayout():Boolean;
		
		function set includeInLayout(value:Boolean):void;
		
		function getExplicitOrMeasuredWidth():Number;
		function getExplicitOrMeasuredHeight():Number

	}
}