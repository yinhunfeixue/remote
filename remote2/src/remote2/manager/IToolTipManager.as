package remote2.manager
{
	import remote2.core.IToolTipElement;

	/**
	 * toolTip管理器接口 
	 * @author yinhunfeixue
	 * @date 2013-5-3
	 */	
	public interface IToolTipManager
	{
		/**
		 * 显示提示
		 * @param target 针对的目标对象
		 * @param toolTip 提示内容
		 * 
		 */		
		function show(target:IToolTipElement, toolTip:String):void;
		
		/**
		 * 隐藏提示 
		 * @param target 目标
		 * 
		 */		
		function hide(target:IToolTipElement):void;
		
		/**
		 * 当前的对象 
		 * 
		 */		
		function get currentTarget():IToolTipElement;
	}
}