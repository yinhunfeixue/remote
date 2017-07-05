package remote2.core
{
	
	/**
	 * 滚动条显示策略
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class ScrollPolicy
	{
		/**
		 * 如果子项超出所有者的尺寸，则显示滚动栏。 
		 */		
		public static const AUTO:String = "auto";
		
		/**
		 * 从不显示滚动栏。 
		 */		
		public static const OFF:String = "off";
		
		/**
		 * 总是显示滚动栏。 
		 */		
		public static const ON:String = "on";
	}
}