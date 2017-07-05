package remote2.core
{
	import remote2.components.SkinnableComponent;

	/**
	 * 皮肤接口 
	 * @author yinhunfeixue
	 * @date 2013-5-24
	 */	
	public interface ISkin
	{
		/**
		 * 安装皮肤，此方法中进行皮肤的初始化，不需要重绘
		 * 
		 */		
		function install():void;
		
		/**
		 *  卸载皮肤
		 * 
		 */		
		function uninstall():void;
		
		/**
		 * 更新 
		 * @param unscaleWidth 组件宽度
		 * @param unscaleHeight 组件高度
		 * 
		 */		
		function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void;
		
		/**
		 *  状态变化
		 * @param newState 新状态名称
		 * @param oldState 旧状态名称
		 * 
		 */		
		function styleChange(newState:String, oldState:String):void;
		
		/**
		 * 组件 
		 * 
		 */		
		function set target(value:SkinnableComponent):void;
		function get target():SkinnableComponent;
	}
}