package remote2.geom
{
	import remote2.IClone;
	
	/**
	 * 表示可视组件周围四个边缘区域的粗细
	 * @author 银魂飞雪
	 * @createDate 2011-2-26
	 */
	public class EdgeMetrics implements IClone
	{
		/**
		 * 下边缘宽度 
		 */		
		public var bottom:Number;
		
		/**
		 * 左边缘宽度 
		 */		
		public var left:Number;
		
		/**
		 * 右边缘宽度 
		 */		
		public var right:Number;
		
		/**
		 * 上边缘宽度 
		 */		
		public var top:Number;
		
		/**
		 * 实例化
		 * @param left 左边缘宽度 
		 * @param top 上边缘宽度
		 * @param right 右边缘宽度
		 * @param bottom 下边缘宽度
		 * 
		 */		
		public function EdgeMetrics(left:Number = 0, top:Number = 0,
									right:Number = 0, bottom:Number = 0)
		{
			super();
			
			this.left = left;
			this.top = top;
			this.right = right;
			this.bottom = bottom;
		}

		/**
		 * 比较是否相同
		 * @param edge 作比较的对象
		 * @return 是否相同
		 * 
		 */		
		public function equal(edge:EdgeMetrics):Boolean
		{
			return left == edge.left && top == edge.top && right == edge.right && bottom == edge.bottom;
		}
		/**
		 * @inheritDoc
		 */	
		public function clone():Object
		{
			return new EdgeMetrics(left, top, right, bottom);
		}
	}
}