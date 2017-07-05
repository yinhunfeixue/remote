package remote2.layouts
{
	import flash.geom.Rectangle;
	
	import remote2.components.Group;
	import remote2.components.supports.LayoutComponent;
	import remote2.core.ILayoutElement;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	/**
	 * 水平布局 
	 * @author yinhunfeixue
	 * 
	 */	
	public class HorizontalLayout extends LayoutBase implements ILayout
	{
		private var _gap:int = 0;
		private var _paddingLeft:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingTop:Number = 0;
		private var _paddingBottom:Number = 0;
		private var _horizontalAlign:String = HorizontalAlign.LEFT;
		private var _verticalAlign:String = VerticalAlign.TOP;
		
		public function HorizontalLayout()
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
			updatePercentWidth();
			var childRect:Rectangle = getChildrenRect(target);
			var availablePercentWidth:Number = getAvailablePercentWidth();
			var totalPercentWidth:Number = getTotalPercentWidth();
			switch(_horizontalAlign)
			{
				case HorizontalAlign.CENTER:					//尽量使用中间对齐，但是起始坐标必须大于paddingLeft
					childX = Math.max(paddingLeft, paddingLeft + (width - paddingLeft - paddingRight - childRect.width) / 2);
					break;
				case HorizontalAlign.RIGHT:					//尽量使用右间对齐，但是起始坐标必须大于paddingLeft
					childX = Math.max(paddingLeft, width - paddingRight - childRect.width);
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
					childWidth = availablePercentWidth * Math.min(pWidth / totalPercentWidth,  1);
				}
				if(!isNaN(pHeight))
				{
					var availableHeight:Number = height;
					if(!isNaN(paddingTop))
						availableHeight -= paddingTop;
					if(!isNaN(paddingBottom))
						availableHeight -= paddingBottom;
					childHeight = availableHeight * pHeight * 0.01;
				}
				switch(_verticalAlign)
				{
					case VerticalAlign.TOP:
						childY = paddingTop;
						break;
					case VerticalAlign.MIDDLE:
						childY = Math.max(paddingTop, paddingTop + (height - paddingTop - paddingBottom) / 2 - child.height / 2);
						break;
					case VerticalAlign.BOTTOM:
						childY = Math.max(paddingTop, height- paddingBottom - child.height);
						break;
				}
				child.x = childX;
				child.y = childY;
				childX += child.width + _gap;
				child.setLayoutSize(child.width, childHeight);
			}
		}
		
		public function updatePercentWidth():void
		{
			var len:int = target.numChildren;
			if(len == 0)
				return;
			//把percentWidth为NaN的控件宽度排除在外
			var totalWidth:Number = target.width;
			var totalPercent:Number = 0;
			var i:int, child:ILayoutElement;
			var includeInLayoutLen:int = 0;
			for(i = 0; i < len; i++)
			{
				child = target.getChildAt(i) as ILayoutElement;
				if(child == null || !child.includeInLayout)
					continue;
				
				includeInLayoutLen++;
				if(isNaN(child.percentWidth))
					totalWidth -= child.width;
				else
					totalPercent += child.percentWidth;
			}
			if(!isNaN(_gap))
				totalWidth -= (includeInLayoutLen - 1) * _gap;
			if(!isNaN(paddingLeft))
				totalWidth -= paddingLeft;
			if(!isNaN(paddingRight))
				totalWidth -= paddingRight;
			for(i = 0; i < len; i++)
			{
				child = target.getChildAt(i) as ILayoutElement;
				if(child == null || !child.includeInLayout)
					continue;
				if(!isNaN(child.percentWidth))
					child.setLayoutSize(totalWidth * child.percentWidth / totalPercent, child.height);
			}
		}
		
		public function measure():void
		{
			var layoutTarget:Group = target;
			if (!layoutTarget)
				return;
			
			measureReal(layoutTarget);
			
			layoutTarget.measuredWidth = layoutTarget.measuredWidth;    
			layoutTarget.measuredHeight = layoutTarget.measuredHeight;    
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
				var width:Number = _gap * (len - 1) + _paddingLeft + _paddingRight, height:Number = 0;
				for (var i:int = 0; i < len; i++) 
				{
					var child:LayoutComponent = layoutTarget.getChildAt(i) as LayoutComponent;
					if(child != null && child.includeInLayout)
					{
						width += child.width;
						if(child.height > height)
							height = child.height
					}
				}
				height += _paddingTop + _paddingBottom;
				layoutTarget.measuredWidth = width;
				layoutTarget.measuredHeight = height;
			}
		}
		
		/**
		 * 计算可用于百分比计算的水平像素 
		 * @return 
		 * 
		 */		
		private function getAvailablePercentWidth():Number
		{
			var len:int = target.numChildren;
			var result:Number = target.width;
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var child:ILayoutElement = target.getChildAt(i) as ILayoutElement;
				if(child && child.includeInLayout)
				{
					if(isNaN(child.percentWidth))
						result -= child.width;
				}
			}
			if(!isNaN(paddingLeft))
				result -= paddingLeft;
			if(!isNaN(paddingRight))
				result -= paddingRight;
			return result;
		}
		
		/**
		 * 获取子对象的总百分比值，例如有三个子对象，percentWidth分别是100，80，NaN，则此方法返回值为100 + 80 = 180
		 * @return 
		 * 
		 */		
		private function getTotalPercentWidth():Number
		{
			var len:int = target.numChildren;
			var result:Number = 0;
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var child:ILayoutElement = target.getChildAt(i) as ILayoutElement;
				if(child && child.includeInLayout)
				{
					if(!isNaN(child.percentWidth))
						result += child.percentWidth;
				}
			}
			return result;
		}
		
		private function getChildrenRect(layoutTarget:Group):Rectangle
		{
			var len:int = layoutTarget.numChildren;
			if(len == 0)
			{
				return new Rectangle();
			}
			var width:Number = _gap * (len - 1), height:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				var child:LayoutComponent = layoutTarget.getChildAt(i) as LayoutComponent;
				if(child != null && child.includeInLayout)
				{
					width += child.width;
					if(child.height > height)
						height = child.height;
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