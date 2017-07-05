package remote2.components
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import remote2.core.IViewport;
	import remote2.events.ResizeEvent;
	import remote2.events.ScrollEvent;
	import remote2.layouts.ILayout;
	
	[Event(name="horizontalValueChanged", type="remote2.events.ScrollEvent")]
	[Event(name="verticalValueChanged", type="remote2.events.ScrollEvent")]
	[Event(name="maxHorizontalValueChanged", type="remote2.events.ScrollEvent")]
	[Event(name="maxVerticalValueChanged", type="remote2.events.ScrollEvent")]
	/**
	 * 具有滚动功能的容器，本身不提供滚动条，需要和其它滚动条配合使用
	 * 若需要自带滚动条的容器，可使用Scroller
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-7
	 */	
	public class ScrollContainer extends Group implements IViewport
	{
		
		private var _maskShape:Shape;
		
		private var _content:UIComponent;
		private var _verticalScrollValue:Number = 0;
		private var _verticalScrollValueChanged:Boolean;
		
		private var _horizontalScrollValue:Number = 0;
		private var _horizontalSCrollValueChanged:Boolean;
		
		private var _maxHorizontalScrollValue:Number = 0;
		private var _maxVerticalScrollValue:Number = 0;
		
		
		private var _commitScrollValue:Boolean = false;
		
		public function ScrollContainer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_maskShape = new Shape();
			var g:Graphics = _maskShape.graphics;
			g.clear();
			g.beginFill(0, 0.7);
			g.drawRect(0, 0, 1, 1);
			g.endFill();
			addChild(_maskShape);
			mask = _maskShape;
		}
		
		private function commitHorizontalScrollValue():void
		{
			if(isNaN(_horizontalScrollValue) || _horizontalScrollValue < 0)
				_horizontalScrollValue = 0;
			if(_horizontalScrollValue > maxHScrollValue)
				_horizontalScrollValue = maxHScrollValue;
			dispatchEvent(new ScrollEvent(ScrollEvent.HORIZONTAL_VALUE_CHANGED, _horizontalScrollValue));
		}
		
		private function commitVerticalScrollValue():void
		{
			
			if(isNaN(_verticalScrollValue) || _verticalScrollValue < 0)
				_verticalScrollValue = 0;
			if(_verticalScrollValue > maxVScrollValue)
				_verticalScrollValue = maxVScrollValue;
			dispatchEvent(new ScrollEvent(ScrollEvent.VERTICAL_VALUE_CHANGED, _verticalScrollValue));
		}
		
		private function setMaxHScrollValue(value:Number):void
		{
			if(isNaN(value))
				value = 0;
			if(_maxHorizontalScrollValue != value)
			{
				_maxHorizontalScrollValue = value;
				dispatchEvent(new ScrollEvent(ScrollEvent.MAX_HORIZONTAL_VALUE_CHANGED, value));
			}
		}
		
		private function setMaxVScrollValue(value:Number):void
		{
			if(isNaN(value))
				value = 0;
			if(_maxVerticalScrollValue != value)
			{
				_maxVerticalScrollValue = value;
				dispatchEvent(new ScrollEvent(ScrollEvent.MAX_VERTICAL_VALUE_CHANGED, value));
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_verticalScrollValueChanged || _horizontalSCrollValueChanged)
			{
				if(_verticalScrollValueChanged)
				{
					_verticalScrollValueChanged = false;
					commitVerticalScrollValue();
				}
				if(_horizontalSCrollValueChanged)
				{
					_horizontalSCrollValueChanged = false;
					commitHorizontalScrollValue();
				}
				if(_content)
				{
					_content.x = -horizontalScrollValue;
					_content.y = -verticalScrollValue;
				}
			}
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			_maskShape.width = unscaleWidth;
			_maskShape.height = unscaleHeight;
			if(_content)
			{
				setMaxHScrollValue(Math.max(0, _content.width - unscaleWidth));
				setMaxVScrollValue(Math.max(0, _content.height - unscaleHeight));
			}
		}
		
		override public function set layout(value:ILayout):void
		{
			throw new Error("can't set  layout for Scroller");
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get maxVScrollValue():Number
		{
			return _maxVerticalScrollValue;
		}
		
		public function get maxHScrollValue():Number
		{
			return _maxHorizontalScrollValue;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get horizontalScrollValue():Number
		{
			return _horizontalScrollValue;
		}
		
		public function set horizontalScrollValue(value:Number):void
		{
			if(_horizontalScrollValue != value)
			{
				_horizontalScrollValue = value;
				_horizontalSCrollValueChanged = true;
				
				invalidateProperties();
				invalidateDisplayList();
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get verticalScrollValue():Number
		{
			return _verticalScrollValue;
		}
		
		public function set verticalScrollValue(value:Number):void
		{
			if(_verticalScrollValue != value)
			{
				_verticalScrollValue = value;
				_verticalScrollValueChanged = true;
				
				invalidateProperties();
				invalidateDisplayList();
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get contentWidth():Number
		{
			if(content)
				return content.width;
			return 0;
		}
		/**
		 * @inheritDoc
		 */	
		public function get contentHeight():Number
		{
			if(content)
				return content.height;
			return 0;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get horizontalSpeed():Number
		{
			return 0;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get verticalSpeed():Number
		{
			return 0;
		}
		
		/**
		 * 滚动内容 
		 * 
		 */	
		public function get content():UIComponent
		{
			return _content;
		}
		
		public function set content(value:UIComponent):void
		{
			if(_content != value)
			{
				if(_content != null)
				{
					_content.removeEventListener(ResizeEvent.RESIZE, content_resizeHandler);
					removeChild(_content);
				}
				_content = value;
				if(_content)
				{
					addChildAt(_content, 0);
					_content.addEventListener(ResizeEvent.RESIZE, content_resizeHandler);
					invalidateDisplayList();
				}
				else
				{
					setMaxHScrollValue(0);
					setMaxVScrollValue(0);
					horizontalScrollValue = 0;
					verticalScrollValue = 0;
				}
				
			}
		}
		
		protected function content_resizeHandler(event:ResizeEvent):void
		{
			invalidateDisplayList();
		}
	}
}