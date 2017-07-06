package remote2.components.supports
{
	import remote2.components.UIComponent;
	import remote2.core.ILayoutElement;
	import remote2.core.remote_internal;
	import remote2.events.ResizeEvent;
	import remote2.geom.Size;
	
	use namespace remote_internal;
	
	/**
	 * 支持布局设置的组件基类
	 * 本身具有布局属性，但是只有当被添加到LayoutComponent中时，布局属性才会生效 
	 * 自定义组件时，不建议使用此类作为基类
	 * @author xujunjie
	 * 
	 */	
	public class LayoutComponent extends UIComponent implements ILayoutElement
	{
		private var _left:Number;
		private var _top:Number;
		private var _bottom:Number;
		private var _right:Number;
		private var _horizontalCenter:Number;
		private var _verticalCenter:Number;
		private var _percentWidth:Number;
		private var _percentHeight:Number;
		private var _includeInLayout:Boolean;
		
		private var _layoutWidth:Number;
		
		private var _layoutHeight:Number;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function LayoutComponent()
		{
			super();
			_includeInLayout = true;
		}
		/**
		 * @inheritDoc
		 */	
		override public function set width(value:Number):void
		{
			_percentWidth = NaN;
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			_percentHeight = NaN;
			super.height = value;
		}
		/**
		 * @inheritDoc
		 */	
		public function get left():Number
		{
			return _left;
		}
		
		public function set left(value:Number):void
		{
			if(_left != value)
			{
				_left = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get right():Number
		{
			return _right;
		}
		
		public function set right(value:Number):void
		{
			if(_right != value)
			{
				_right = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get top():Number
		{
			return _top;
		}
		
		public function set top(value:Number):void
		{
			if(_top != value)
			{
				_top = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get bottom():Number
		{
			return _bottom;
		}
		
		public function set bottom(value:Number):void
		{
			if(_bottom != value)
			{
				_bottom = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get horizontalCenter():Number
		{
			return _horizontalCenter;
		}
		
		public function set horizontalCenter(value:Number):void
		{
			if(_horizontalCenter != value)
			{
				_horizontalCenter = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get verticalCenter():Number
		{
			return _verticalCenter;
		}
		
		public function set verticalCenter(value:Number):void
		{
			if(_verticalCenter != value)
			{
				_verticalCenter = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		public function set percentWidth(value:Number):void
		{
			if(_percentWidth != value)
			{
				_percentWidth = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		public function set percentHeight(value:Number):void
		{
			if(_percentHeight != value)
			{
				_percentHeight = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get includeInLayout():Boolean
		{
			return _includeInLayout;
		}
		
		public function set includeInLayout(value:Boolean):void
		{
			if(_includeInLayout != value)
			{
				_includeInLayout = value;
				invalidateParentSizeAndDisplayList();
			}
		}
		
		public function setLayoutPosition(x:Number, y:Number):void
		{
			if(this.x != x || this.y != y)
			{
				this.x = x;
				this.y = y;
				invalidateParentSizeAndDisplayList();
			}
		}
		
		override protected function measure():void
		{
			measuredWidth = _layoutWidth;
			measuredHeight = _layoutHeight;
		}
		/**
		 * @inheritDoc
		 */	
		public function setLayoutSize(width:Number, height:Number):void
		{
			if(isNaN(width))
				width = getExplicitOrMeasuredWidth();
			if(isNaN(height))
				height = getExplicitOrMeasuredHeight();
			if(this.width != width || this.height != height)
			{
				_layoutWidth = width;
				_layoutHeight = height;
				invalidateSize();
			//	validateSize()
			}
		}
		/**
		 * @inheritDoc
		 */	
		override remote_internal function invalidateParentSizeAndDisplayList():void
		{
			if(includeInLayout)
				super.invalidateParentSizeAndDisplayList();
		}

		/**
		 * 根据top,left被父窗口设置的布局宽度 
		 */
		public function get layoutWidth():Number
		{
			return _layoutWidth;
		}

		/**
		 * 根据top bottom 被父窗口设置的布局宽度 
		 */
		public function get layoutHeight():Number
		{
			return _layoutHeight;
		}

		
	}
}