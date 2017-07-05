package remote2.geom
{
	import remote2.IClone;
	
	
	/**
	 * 表示尺寸的数据结构
	 * @author 银魂飞雪
	 * @createDate 2011-2-26
	 */
	public class Size implements IClone
	{
		/**
		 * 宽度 
		 */		
		public var width:Number;
		
		/**
		 * 高度 
		 */		
		public var height:Number;
		
		/**
		 * 实例化 
		 * @param w 宽度
		 * @param h 高度
		 * 
		 */		
		public function Size(w:Number = 0, h:Number = 0)
		{
			width = w;
			height = h;
		}
		
		/**
		 * 比较是否相同 
		 * @param size 用作比较的对象
		 * @return 是否相同
		 * 
		 */		
		public function equal(size:Size):Boolean
		{
			return width == size.width && height == size.height;
		}
		
		public function clone():Object
		{
			return new Size(width, height);
		}
	}
}