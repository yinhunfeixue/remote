package remote2.graphics
{
	
	/**
	 * 定义了调整大小模式的一个枚举，这些模式确定 Image 如何填充由布局系统指定的尺寸。
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class ImageFillMode
	{
		/**
		 * 剪切模式 
		 */		
		public static const CLIP:String = "clip";
		
		/**
		 * 重复平铺模式
		 */		
		public static const REPEAT:String = "repeat";
		
		/**
		 * 缩放模式 
		 */		
		public static const SCALE:String = "scale";
	}
}