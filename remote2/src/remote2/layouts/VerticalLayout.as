package remote2.layouts
{
	import flash.geom.Rectangle;
	
	import remote2.components.Group;
	import remote2.components.supports.LayoutComponent;
	import remote2.core.ILayoutElement;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	/**
	 * 竖直布局
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-8
	 */	
	public class VerticalLayout extends LayoutBase implements ILayout
	{
		private var _gap:int = 0;
		private var _paddingLeft:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingTop:Number = 0;
		private var _paddingBottom:Number = 0;
		private var _horizontalAlign:String = HorizontalAlign.LEFT;
		private var _verticalAlign:String = VerticalAlign.TOP;
		
		
		public function VerticalLayout()
		{
			super();
		}
		
		public function updateChildren(width:Number, height:Number):void
		{
			var len:int = target.numChildren;
			if(len == 0)
				return;
			var childX:Number = paddingLeft;
			var childY:Number = paddingTop;
			var childRect:Rectangle = getChildrenRect(target);
			var availablePercentHeight:Number = getAvailablePercentHeight();
			var totalPercentHeight:Number = getTotalPercentHeight();
			switch(_verticalAlign)
			{
				case VerticalAlign.MIDDLE:					//尽量使用中间对齐，但是起始坐标必须大于paddingLeft
					childY = Math.max(paddingTop, paddingTop + (height - paddingTop - paddingBottom - childRect.height) / 2);
					break;
				case VerticalAlign.BOTTOM:					//尽量使用右间对齐，但是起始坐标必须大于paddingLeft
					childY = Math.max(paddingTop, height - paddingBottom - childRect.height);
					break;
			}
			
			for(var i:int = 0; i < len; i++)
			{
				var child:ILayoutElement = target.getChildAt(i) as ILayoutElement;
				if(child == null || !child.includeInLayout)
					continue;
				var pWidth:Number = child.percentWidth;
				var pHeight:Number = child.percentHeight;
				var childWidth:Number, childHeight:Number;
				
				if(!isNaN(pWidth))
				{
					var availableWidth:Number = width;
					if(!isNaN(paddingLeft))
						availableWidth -= paddingLeft;
					if(!isNaN(paddingRight))
						availableWidth -= paddingRight;
					childWidth = availableWidth * Math.min(pWidth * 0.01, 1);
				}
				if(!isNaN(pHeight))
				{
					childHeight = availablePercentHeight * Math.min(pHeight / totalPercentHeight, 1);
				}
				switch(_horizontalAlign)
				{
					case HorizontalAlign.LEFT:
						childX = paddingLeft;
						break;
					case HorizontalAlign.CENTER:
						childX = Math.max(paddingLeft, paddingLeft + (width - paddingLeft - paddingRight - child.width) / 2);
						break;
					case VerticalAlign.BOTTOM:
						childX = Math.max(paddingLeft, width- paddingRight - child.width);
						break;
				}
				child.x = childX;
				child.y = childY;
				child.setLayoutSize(childWidth, childHeight);
				childY += child.height + _gap;
			}
		}
		
		public function measure():void
		{
			var layoutTarget:Group = target;
			if (!layoutTarget)
				return;
			
			measureReal(layoutTarget);
		}
		
		private function measureReal(layoutTarget:Group):void
		{
			var len:int = layoutTarget.numChildren;
			if(len == 0)
			{
				layoutTarget.measuredWidth = 0;
				layoutTarget.measuredHeight = 0;
			}
			else
			{
				var height:Number = _gap * (len - 1) + _paddingTop + _paddingBottom, width:Number = 0;
				for (var i:int = 0; i < len; i++) 
				{
					var child:LayoutComponent = layoutTarget.getChildAt(i) as LayoutComponent;
					if(child != null && child.includeInLayout)
					{
						height += child.height;
						if(child.width > width)
							width = child.width
					}
				}
				width += _paddingLeft + _paddingRight;
				layoutTarget.measuredWidth = width;
				layoutTarget.measuredHeight = height;
			}
		}
		
		/**
		 * 计算可用于百分比计算的竖直像素 
		 * @return 
		 * 
		 */		
		private function getAvailablePercentHeight():Number
		{
			var len:int = target.numChildren;
			var result:Number = target.height;
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var child:ILayoutElement = target.getChildAt(i) as ILayoutElement;
				if(child && child.includeInLayout)
				{
					if(isNaN(child.percentHeight))
						result -= child.height;
				}
			}
			if(!isNaN(paddingTop))
				result -= paddingTop;
			if(!isNaN(paddingBottom))
				result -= paddingBottom;
			return result;
		}
		
		/**
		 * 获取子对象的总百分比值，例如有三个子对象，percentHeight分别是100，80，NaN，则此方法返回值为100 + 80 = 180
		 * @return 
		 * 
		 */		
		private function getTotalPercentHeight():Number
		{
			var len:int = target.numChildren;
			var result:Number = 0;
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var child:ILayoutElement = target.getChildAt(i) as ILayoutElement;
				if(child && child.includeInLayout)
				{
					if(!isNaN(child.percentHeight))
						result += child.percentHeight;
				}
			}
			return result;
		}
		
		/**
		 * 获取子对象占用的区域
		 * @param layoutTarget
		 * @return 
		 * 
		 */		
		private function getChildrenRect(layoutTarget:Group):Rectangle
		{
			var len:int = layoutTarget.numChildren;
			if(len == 0)
			{
				return new Rectangle();
			}
			var height:Number = _gap * (len - 1), width:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				var child:LayoutComponent = layoutTarget.getChildAt(i) as LayoutComponent;
				if(child != null && child.includeInLayout)
				{
					height += child.height;
					if(child.width > width)
						width = child.width;
				}
			}
			return new Rectangle(_paddingLeft, _paddingTop, width, height);
		}
		
		public function get gap():int
		{
			return _gap;
		}
		
		/**
		 *  @private
		 */
		public function set gap(value:int):void
		{
			if (_gap == value) 
				return;
			
			_gap = value;
		}
		
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
		}
		
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
		}
		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
		}
		
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
		}
		
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
		}
		
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
		}
	}
}