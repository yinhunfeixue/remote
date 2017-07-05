package remote2.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import remote2.core.IViewport;
	import remote2.core.ScrollPolicy;
	import remote2.core.remote_internal;
	import remote2.events.ScrollEvent;
	
	use namespace remote_internal;
	
	/**
	 * 只有水平滚动条显示 
	 */	
	[SkinState("horizontalShow")]
	
	/**
	 * 只有竖直滚动条显示 
	 */	
	[SkinState("verticalShow")]
	
	/**
	 * 两个滚动条都显示 
	 */	
	[SkinState("bothShow")]
	
	/**
	 * 两个滚动条都隐藏
	 */	
	[SkinState("bothHide")]
	/**
	 * 滚动容器，包含水平和竖直滚动条
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class Scroller extends SkinnableComponent
	{
		protected function get horizontalScollBar():HScrollBar
		{
			return findSkinPart("horizontalScollBar", false);
		}
		
		protected function get verticalScollBar():VScrollBar
		{
			return findSkinPart("verticalScollBar", false);
		}
		
		private var _horizontalPolicy:String = ScrollPolicy.AUTO;
		
		private var _verticalScrollPolicy:String = ScrollPolicy.AUTO;
		
		private var _verticalScrollValue:Number = 0;
		private var _horizontalScrollValue:Number = 0;
		
		
		private var _viewport:IViewport;
		
		private var _scrollValueChanged:Boolean = true;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function Scroller()
		{
			super();
		}
		
		override protected function getCurrentState():String
		{
			if(enabled)
			{
				if(hscrollVisible && vscrollVisible)
					return "bothShow";
				else if(hscrollVisible)
					return "horizontalShow";
				else if(vscrollVisible)
					return "verticalShow";
				else
					return "bothHide";
			}
			else
				return super.getCurrentState();
		}
		
		private function get hscrollVisible():Boolean
		{
			var result:Boolean = false;
			switch(_horizontalPolicy)
			{
				case ScrollPolicy.OFF:
					result = false;
					break;
				case ScrollPolicy.ON:
					result = true;
					break;
				case ScrollPolicy.AUTO:
					result = (maxHorizontalScrollValue > 0);
					break;
			}
			return result;
		}
		
		private function get vscrollVisible():Boolean
		{
			var result:Boolean = false;
			switch(_verticalScrollPolicy)
			{
				case ScrollPolicy.OFF:
					result = false;
					break;
				case ScrollPolicy.ON:
					result = true;
					break;
				case ScrollPolicy.AUTO:
					result = (maxVerticalScrollValue > 0);
					break;
			}
			return result;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_scrollValueChanged)
			{
				_scrollValueChanged = false;
				if(horizontalScollBar)
				{
					horizontalScollBar.value = horizontalScrollValue;
					horizontalScollBar.maximum = maxHorizontalScrollValue;
					horizontalScollBar.visible = hscrollVisible;
				}
				if(verticalScollBar)
				{
					verticalScollBar.value = verticalScrollValue;
					verticalScollBar.maximum = maxVerticalScrollValue;
					verticalScollBar.visible = vscrollVisible;
				}
				validateSkinState();
			}
		}
		
		private function addViewportListener():void
		{
			viewport.addEventListener(ScrollEvent.HORIZONTAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.addEventListener(ScrollEvent.VERTICAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.addEventListener(ScrollEvent.MAX_HORIZONTAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.addEventListener(ScrollEvent.MAX_VERTICAL_VALUE_CHANGED, container_scrollValueChanged);
		}
		
		private function removeViewportListener():void
		{
			viewport.removeEventListener(ScrollEvent.HORIZONTAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.removeEventListener(ScrollEvent.VERTICAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.removeEventListener(ScrollEvent.MAX_HORIZONTAL_VALUE_CHANGED, container_scrollValueChanged);
			viewport.removeEventListener(ScrollEvent.MAX_VERTICAL_VALUE_CHANGED, container_scrollValueChanged);
		}
		
		protected function container_scrollValueChanged(event:ScrollEvent):void
		{
			switch(event.type)
			{
				case ScrollEvent.HORIZONTAL_VALUE_CHANGED:
					_horizontalScrollValue = event.value;
					invalidateScrollProperties();
					break;
				case ScrollEvent.VERTICAL_VALUE_CHANGED:
					_verticalScrollValue = event.value;
					invalidateScrollProperties();
					break;
				case ScrollEvent.MAX_HORIZONTAL_VALUE_CHANGED:
				case ScrollEvent.MAX_VERTICAL_VALUE_CHANGED:
					invalidateScrollProperties();
					break;
			}
		}
		
		protected function installViewport(viewport:IViewport):void
		{
			viewport.horizontalScrollValue = horizontalScrollValue;
			viewport.verticalScrollValue = verticalScrollValue;
			addChildAt(viewport as DisplayObject, 0);
			addViewportListener();
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			if(horizontalScollBar)
				horizontalScollBar.addEventListener(Event.CHANGE, horizontalScollBar_changeHandler);
			if(verticalScollBar)
				verticalScollBar.addEventListener(Event.CHANGE, verticalScollBar_changeHandler);
		}
		
		override protected function onSkinRemoveing():void
		{
			if(horizontalScollBar)
				horizontalScollBar.removeEventListener(Event.CHANGE, horizontalScollBar_changeHandler);
			if(verticalScollBar)
				verticalScollBar.removeEventListener(Event.CHANGE, verticalScollBar_changeHandler);
			super.onSkinAdded();
		}
		
		protected function verticalScollBar_changeHandler(event:Event):void
		{
			verticalScrollValue = verticalScollBar.value;
		}
		
		protected function horizontalScollBar_changeHandler(event:Event):void
		{
			horizontalScrollValue = horizontalScollBar.value;
		}
		
		/**
		 * 视图内容，滚动对象 
		 * 
		 */		
		public function get viewport():IViewport
		{
			return _viewport;
		}
		
		public function set viewport(value:IViewport):void
		{
			if(viewport != value)
			{
				if(_viewport)
				{
					removeChild(_viewport as DisplayObject);
					removeViewportListener();
				}
				_viewport = value;
				if(_viewport)
				{
					installViewport(_viewport);
				}
				invalidateScrollProperties();
	
			}
		}
		
		private function invalidateScrollProperties():void
		{
			_scrollValueChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 水平方向当前滚动值 
		 * 
		 */		
		public function get horizontalScrollValue():Number
		{
			return _horizontalScrollValue;
		}
		
		public function set horizontalScrollValue(value:Number):void
		{
			if(horizontalScrollValue != value)
			{
				_horizontalScrollValue = value;
				if(_viewport)
					_viewport.horizontalScrollValue = value;
				invalidateScrollProperties();
			}
		}
		
		/**
		 * 竖直方向当前滚动值
		 * 
		 */		
		public function get verticalScrollValue():Number
		{
			return _verticalScrollValue;
		}
		
		public function set verticalScrollValue(value:Number):void
		{
			if(verticalScrollValue != value)
			{
				_verticalScrollValue = value;
				if(_viewport)
					_viewport.verticalScrollValue = value;
				invalidateScrollProperties();
			}
		}
		
		/**
		 * 水平方向最大滚动值 
		 * 
		 */		
		public function get maxHorizontalScrollValue():Number
		{
			if(viewport)
				return viewport.maxHScrollValue;
			return 0;
		}
		
		/**
		 * 竖直方向最大滚动值 
		 * 
		 */		
		public function get maxVerticalScrollValue():Number
		{
			if(viewport)
				return viewport.maxVScrollValue;
			return 0;
		}
		
		/**
		 * 水平滚动条的显示策略
		 * @see  remote2.core.ScrollPolicy
		 */
		public function get horizontalPolicy():String
		{
			return _horizontalPolicy;
		}
		
		/**
		 * @private
		 */
		public function set horizontalPolicy(value:String):void
		{
			if(_horizontalPolicy != value)
			{
				_horizontalPolicy = value;
				invalidateScrollProperties();
			}
		}
		
		/**
		 * 竖直滚动条的显示策略
		 * @see  remote2.core.ScrollPolicy
		 */
		public function get verticalScrollPolicy():String
		{
			return _verticalScrollPolicy;
		}
		
		/**
		 * @private
		 */
		public function set verticalScrollPolicy(value:String):void
		{
			if(_verticalScrollPolicy != value)
			{
				_verticalScrollPolicy = value;
				invalidateScrollProperties();
			}
		}
	}
}