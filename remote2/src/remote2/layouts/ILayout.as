package remote2.layouts
{
	import remote2.components.Group;

	/**
	 * 布局接口 
	 * @author xujunjie
	 * 
	 */	
	public interface ILayout
	{
		/**
		 * 更新子对象的位置和尺寸  
		 * @param width 
		 * @param height
		 * @return 
		 * 
		 */		
		function updateChildren(width:Number, height:Number):void;
		
		/**
		 * 测量 
		 * 
		 */		
		function measure():void;
		
		/**
		 * 布局对象 
		 * 
		 */		
		function get target():Group;
		function set target(value:Group):void;
	}
}