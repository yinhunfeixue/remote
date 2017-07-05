package remote2.layouts
{
	import remote2.components.Group;
	import remote2.components.UIComponent;
	import remote2.components.supports.LayoutComponent;
	import remote2.core.ILayoutElement;
	import remote2.core.remote_internal;

	use namespace remote_internal;
	
	/**
	 * 绝对布局 
	 * @author yinhunfeixue
	 * 
	 */	
	public class BasicLayout extends LayoutBase implements ILayout
	{
		/**
		 * 实例化 
		 * 
		 */		
		public function BasicLayout()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */	
		public function updateChildren(width:Number, height:Number):void
		{
			var layoutTarget:Group = target;
			if(layoutTarget == null)
				return;
			
			var count:int = layoutTarget.numChildren;
			for (var i:int = 0; i < count; i++) 
			{
				var layoutElement:ILayoutElement = layoutTarget.getChildAt(i) as ILayoutElement;
				if(layoutElement == null || !layoutElement.includeInLayout)
					continue;
				
				var left:Number = layoutElement.left;
				var right:Number = layoutElement.right;
				var top:Number = layoutElement.top;
				var bottom:Number = layoutElement.bottom;
				var hCenter:Number = layoutElement.horizontalCenter;
				var vCenter:Number = layoutElement.verticalCenter;
				var pWidth:Number = layoutElement.percentWidth;
				var pHeight:Number = layoutElement.percentHeight;
				
				var childWidth:Number = NaN;
				var childHeight:Number = NaN;
				if(!isNaN(pWidth))
				{
					var availableWidth:Number = width;
					if(!isNaN(left))
						availableWidth -= left;
					else
						availableWidth -= layoutElement.x;
					if(!isNaN(right))
						availableWidth -= right;
					childWidth = availableWidth * Math.min(pWidth * 0.01, 1);
				}
				else if(!isNaN(left) && !isNaN(right))
				{
					childWidth = width - right - left;
				}
				
				if(!isNaN(pHeight))
				{
					var availableHeight:Number = height;
					if(!isNaN(top))
						availableHeight -= top;
					if(!isNaN(bottom))
						availableHeight -= bottom;
					childHeight = availableHeight * Math.min(pHeight * 0.01, 1) - layoutElement.y;
				}
				else if(!isNaN(top) && !isNaN(bottom))
				{
					childHeight = height - bottom - top;
				}
				
				layoutElement.setLayoutSize(childWidth, childHeight);
				
				
				//位置
				var childX:Number = NaN;
				var childY:Number = NaN;
				if(!isNaN(hCenter))
					childX = (width - layoutElement.width) / 2 + hCenter;
				else if(!isNaN(left))
					childX = left;
				else if(!isNaN(right))
					childX = width - layoutElement.width - right;
				else
					childX = layoutElement.x;
				
				if(!isNaN(vCenter))
					childY = (height - layoutElement.height) / 2 + vCenter;
				else if(!isNaN(top))
					childY = top;
				else if(!isNaN(bottom))
					childY = height - layoutElement.height - bottom;
				else
					childY = layoutElement.y;
				
				layoutElement.x = childX;
				layoutElement.y = childY;
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function measure():void
		{
			var layoutTarget:Group = target;
			if(layoutTarget == null)
				return;
			
			var width:Number = 0;
			var height:Number = 0;
			
			var count:int = layoutTarget.numChildren;
			for (var i:int = 0; i < count; i++) 
			{
				var layoutElement:ILayoutElement = layoutTarget.getChildAt(i) as ILayoutElement;
				if(layoutElement == null || !layoutElement.includeInLayout)
					continue;
				
				var left:Number = layoutElement.left;
				var right:Number = layoutElement.right;
				var top:Number = layoutElement.top;
				var bottom:Number = layoutElement.bottom;
				var hCenter:Number = layoutElement.horizontalCenter;
				var vCenter:Number = layoutElement.verticalCenter;
				
				var extendsX:Number;
				var extendsY:Number;
				
				if(!isNaN(left) && !isNaN(right))
				{
					extendsX = left + right;
				}
				else if(!isNaN(hCenter))
				{
					extendsX = Math.abs(hCenter) * 2;
				}
				else if(!isNaN(left) || !isNaN(right))
				{
					extendsX = isNaN(left)?0:left;
					extendsX += isNaN(right)?0:right;
				}
				else
				{
					extendsX = layoutElement.x;
				}
				
				if(!isNaN(top) && !isNaN(bottom))
				{
					extendsY = top + bottom;
				}
				else if(!isNaN(hCenter))
				{
					extendsY = Math.abs(hCenter) * 2;
				}
				else if(!isNaN(top) || !isNaN(bottom))
				{
					extendsY = isNaN(top)?0:top;
					extendsY += isNaN(bottom)?0:bottom;
				}
				else
				{
					extendsY = layoutElement.y;
				}
				
				var preferredWidth:Number = layoutElement.getExplicitOrMeasuredWidth();
				var preferredHeight:Number = layoutElement.getExplicitOrMeasuredHeight();
				
				width = Math.max(width, extendsX + preferredWidth);
				height = Math.max(height, extendsY + preferredHeight);
			}
			
			layoutTarget.measuredWidth = width;
			layoutTarget.measuredHeight = height;			
		}
	}
}