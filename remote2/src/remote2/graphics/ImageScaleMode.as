package remote2.graphics
{
	
	/**
	 * 类定义缩放模式的一个枚举，这些模式确定当 fillMode 设置为 SCALE 时 Image 如何缩放图像内容。
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class ImageScaleMode
	{
		/**
		 * 缩放图片，使图像刚好完全填充控件（可能会导致图像比例变化） 
		 */		
		public static const STRETCH:String = "stretch";
		
		/**
		 * 按比例缩放图像，并且使最大边刚好填充控件； 控件会有一部分空白，空白的位置取决于对齐方式
		 * @example 
		 * 图片原始尺寸为100 100，控件尺寸为100 200，则图片将被缩放为100 100的尺寸，由于控件高度过高，竖直方向将有空白
		 */		
		public static const LETTERBOX:String = "letterbox";
		
		/**
		 * 按比例缩放图片，并且使最小边能填满控件（图像可能有一部分显示不全）
		 * @example 图片原始尺寸为100 100，控件尺寸为100 200，则图片将被缩放为200 200的尺寸，由于控件宽度不足，将有一部分宽度被剪切掉
		 */		
		public static const ZOOM:String = "zoom";
	}
}