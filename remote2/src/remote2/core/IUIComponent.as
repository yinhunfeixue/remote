package remote2.core
{
	
	/**
	 * 组件接口
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-13
	 * */
	public interface IUIComponent
	{
		/**
		 * 组件是否可以接受用户交互。
		 * 对于不同的组件，不接受用户交互可能有不同的定义，例如有些仅禁用点击交互，而接受mouseOver。
		 * 
		 */		
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		
		/**
		 * 将此对象移动到指定的 x 和 y 坐标。 
		 * @param x 新的x坐标
		 * @param y 新的y坐标
		 * 
		 */		
		function move(x:Number, y:Number):void;
	}
}