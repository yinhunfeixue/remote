package remote2.core
{
	import flash.events.IEventDispatcher;

	/**
	 * 可验证接口 
	 * @author yinhunfeixue
	 * 
	 */	
	public interface IValidateElement extends IEventDispatcher
	{
		/**
		 * 验证子对象 
		 * 
		 */		
		function validateDisplayList():void;
		
		/**
		 * 验证属性 
		 * 
		 */		
		function validateProperties():void;
		
		/**
		 * 验证尺寸 
		 * 
		 */		
		function validateSize():void;
		
		
		
		/**
		 * 显示深度
		 * 确定容器内各项目的呈示顺序。根据项目的 depth 属性确定这些项目的顺序，具有最低深度的项目在后面，具有较高深度的项目在前面。具有相同深度值的项目按照添加到容器中的顺序显示。
		 * 
		 */		
		function get depth():Number;
		function set depth(value:Number):void;
		
		/**
		 * 标识第一次创建是否完成，只能在LayoutManager中使用 
		 * 
		 */		
		function get updateCompletePendingFlag():Boolean;
		function set updateCompletePendingFlag(value:Boolean):void
	}
}