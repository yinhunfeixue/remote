package remote2.components
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import remote2.core.IToolTipElement;
	import remote2.core.IUIComponent;
	import remote2.core.IValidateElement;
	import remote2.core.IVisualElement;
	import remote2.core.MethodElement;
	import remote2.core.RemoteSprite;
	import remote2.core.ToolTipControl;
	import remote2.core.remote_internal;
	import remote2.events.MoveEvent;
	import remote2.events.RemoteEvent;
	import remote2.events.ResizeEvent;
	import remote2.geom.Size;
	import remote2.manager.LayoutManager;
	import remote2.utils.StringUtil2;
	
	use namespace remote_internal;
	
	/**
	 * 尺寸变化事件  
	 */	
	[Event(name="resize", type="remote2.events.ResizeEvent")]
	
	/**
	 * 初始化完成事件  
	 */	
	[Event(name="initialized", type="remote2.events.RemoteEvent")]
	
	/**
	 * 坐标变化事件 
	 */	
	[Event(name="move", type="remote2.events.MoveEvent")]
	
	/**
	 * 创建完成事件 
	 */	
	[Event(name="creationComplete", type="remote2.events.RemoteEvent")]
	
	/**
	 * 组件基类
	 * 
	 * <br/>
	 * 更新链分为——自己、父对象、子对象
	 * 
	 * 对于组件开发者，一般有下面方法需要重写
	 * commitProperties
	 * updateDraw
	 * measure
	 * updateChildren
	 * 
	 * 除了validateDraw延迟到下一帧执行，其它方法都是同步执行
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-13
	 * */
	public class UIComponent extends RemoteSprite implements IVisualElement, IUIComponent, IValidateElement, IToolTipElement
	{
		private var _depth:int;
		private var _owner:DisplayObject;
		private var _enabled:Boolean;
		
		private var _explicitWidth:Number;
		
		private var _explicitHeight:Number;
		
		private var _measuredWidth:Number = 0;
		
		private var _measuredHeight:Number = 0;
		
		private var _maxMeasureWidth:Number = int.MAX_VALUE;
		private var _maxMeasureHeight:Number = int.MAX_VALUE;
		
		private var _minMeasureWidth:Number = 0;
		
		private var _minMeasureHeight:Number = 0;
		
		/**
		 * 实际的宽度 
		 */		
		private var _width:Number = 0;
		
		/**
		 * 实际的高度 
		 */		
		private var _height:Number = 0;
		
		private var _initialized:Boolean = false;
		
		private var _methodQueue:Vector.<MethodElement>;
		
		private var _invalidateSizeFlag:Boolean = false;
		private var _invalidateDisplayListFlag:Boolean = false;
		private var _invalidatePropertiesFlag:Boolean = false;
		
		private var _toolTipControl:ToolTipControl;
		private var _toolTip:String;
		private var _toolTipChanged:Boolean;
		
		private var _autoDrawRepsonse:Boolean = false;
		private var _autoDrawRepsonseChanged:Boolean = false;
		
		private var _updateCompletePendingFlag:Boolean = false;
		
		public function UIComponent()
		{
			super();
			_depth = 0;
			_enabled = true;
			focusRect = false;
			buttonMode = true;
			useHandCursor = false;
			if(stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		/**
		 * 是否初始化完成  
		 */
		public function get inited():Boolean
		{
			return _initialized;
		}
		
		protected function addedHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			initialize();
		}
		
		/**
		 * 移除所有子对象 
		 * 
		 */		
		public function removeAllChildren():void
		{
			while(numChildren > 0)
				removeChildAt(0);
		}
		
		
		protected function initialize():void
		{
			_initialized = true;
			createChildren();
			invalidateProperties();
			invalidateSize();
			invalidateDisplayList();
			dispatchEventWithCheck(new RemoteEvent(RemoteEvent.INITIALIZED));
		}
		
		private function createToolTipControl():void
		{
			_toolTipControl = new ToolTipControl();
			_toolTipControl.target = this;
		}
		
		protected function createChildren():void
		{
			if(!StringUtil2.isEmpty(_toolTip))
				createToolTipControl();
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get depth():Number
		{
			return _depth;
		}
		
		public function set depth(value:Number):void
		{
			_depth = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get owner():DisplayObject
		{
			return _owner?_owner:parent;
		}
		
		public function set owner(value:DisplayObject):void
		{
			_owner = value;
		}
		/**
		 * @inheritDoc
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		/**
		 * @inheritDoc
		 */
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				invalidateDisplayList();
			}
			for (var i:int = 0; i < numChildren; i++) 
			{
				var child:UIComponent = getChildAt(i) as UIComponent;
				if(child)
					child.enabled = value;
			}
			
		}
		/**
		 * @inheritDoc
		 */
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			if(_explicitWidth != value)
			{
				_explicitWidth = value;
				invalidateSize();
			}
			if(_width != value)
			{
				var oldWidth:Number = _width;
				_width = value;
				invalidateDisplayList();
				invalidateParentSizeAndDisplayList();
				dispatchEventWithCheck(new ResizeEvent(ResizeEvent.RESIZE, oldWidth, height));
			}
		}
		/**
		 * @inheritDoc
		 */
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			if(_explicitHeight != value)
			{
				_explicitHeight = value;
				invalidateSize();
			}
			if(_height != value)
			{
				var oldHeight:Number = _height;
				_height = value;
				invalidateDisplayList();
				invalidateParentSizeAndDisplayList();
				dispatchEventWithCheck(new ResizeEvent(ResizeEvent.RESIZE, width, oldHeight));
				
			}
		}
		/**
		 * @inheritDoc
		 */
		public function move(x:Number, y:Number):void
		{
			if(Math.round(this.x) != Math.round(x) || Math.round(this.y) != Math.round(y))
			{
				var oldX:Number = this.x;
				var oldY:Number = this.y;
				super.x = x;
				super.y = y;
				dispatchEventWithCheck(new MoveEvent(MoveEvent.MOVE, oldX, oldY));
				invalidateParentSizeAndDisplayList();
			}
		}
		
		/**
		 * 设置实际的尺寸，和直接设置 width\height不同，此方法仅对下次重绘有效，并不改变显式尺寸。 
		 * @param newWidth
		 * @param newHeight
		 * 
		 */		
		remote_internal function setActualSize(newWidth:Number, newHeight:Number):void
		{
			trace("setActualSize" + getQualifiedClassName(this));
			var changed:Boolean = false;
			var oldWidth:Number = width, oldHeight:Number = height;
			if(_width != newWidth)
			{
				_width = newWidth;
				changed = true;
			}
			if(_height != newHeight)
			{
				_height = newHeight;
				changed = true;
			}
			
			if(changed)
			{
				dispatchEventWithCheck(new ResizeEvent(ResizeEvent.RESIZE, oldWidth, oldHeight));
				invalidateDisplayList();
			}
		}
		
		/**
		 * 标识父对象更新尺寸、重绘和布局子对象 
		 * 
		 */		
		remote_internal function invalidateParentSizeAndDisplayList():void
		{
			var p:UIComponent = parent as UIComponent;
			if(p == null)
				return;
			p.invalidateSize();
			p.invalidateDisplayList();
		}
		
		remote_internal function getMeasureSize():Size
		{
			var result:Size = new Size();
			if(isNaN(_explicitHeight) || isNaN(_explicitWidth))
			{
				measure();
			}
			result.width = !isNaN(_explicitWidth)?_explicitWidth:_measuredWidth;
			result.height = !isNaN(_explicitHeight)?_explicitHeight:_measuredHeight;
			if(_minMeasureWidth > _maxMeasureWidth)
				_minMeasureWidth = _maxMeasureWidth;
			if(_minMeasureHeight > _maxMeasureHeight)
				_minMeasureHeight = _maxMeasureHeight;
			
			if(result.width < _minMeasureWidth)
				result.width = _minMeasureWidth;
			if(result.height < _minMeasureHeight)
				result.height = _minMeasureHeight;
			
			if(result.width > _maxMeasureWidth)
				result.width = _maxMeasureWidth;
			if(result.height > _maxMeasureHeight)
				result.height = _maxMeasureHeight;
			_measuredWidth = result.width;
			_measuredHeight = result.height;
			return result;
		}
		
		/**
		 * 标记验证属性 
		 * @private
		 */		
		public function invalidateProperties():void
		{
			if(!_invalidatePropertiesFlag && inited)
			{
				LayoutManager.instance.invalidateProperties(this);
				_invalidatePropertiesFlag = true;
			}
		}
		
		/**
		 * 验证重绘和更新子对象 
		 * @private
		 */		
		public function invalidateDisplayList():void
		{
			if(!_invalidateDisplayListFlag && inited)
			{
				LayoutManager.instance.invalidateDisplayList(this);
				_invalidateDisplayListFlag = true;
			}
		}
		
		/**
		 * 推迟更新尺寸
		 * @private 
		 * 
		 */		
		public function invalidateSize():void
		{
			if(!_invalidateSizeFlag && inited)
			{
				LayoutManager.instance.invalidateSize(this);
				_invalidateSizeFlag = true;
			}
		}
		
		/**
		 * 立刻验证属性，尺寸，重绘和子对象 
		 * 
		 */		
		public function validateNow():void
		{
			_invalidatePropertiesFlag = true;
			_invalidateSizeFlag = true;
			_invalidateDisplayListFlag = true;
			validateProperties();
			validateSize();
			validateDisplayList();
		}
		
		/**
		 * 验证重绘和更新子对象 
		 * @private
		 */		
		public function validateDisplayList():void
		{
			if(_invalidateDisplayListFlag)
			{
				_invalidateDisplayListFlag = false;
				updateDisplayList(width, height);
				//				trace("validateDisplayList");
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function validateProperties():void
		{
			if(_invalidatePropertiesFlag)
			{
				_invalidatePropertiesFlag = false
				commitProperties();
				//				trace("validateP");
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function validateSize():void
		{
			if(_invalidateSizeFlag)
			{
				_invalidateSizeFlag = false;
				var oldWidth:Number = width;
				var oldHeight:Number = height;
				var size:Size = getMeasureSize();
				_width = size.width;
				_height = size.height;
				
				if(oldWidth != width || oldHeight != height)									//若尺寸变化，则更新子对象，同时通知父对象验证尺寸
				{
					trace("validateSize" + getQualifiedClassName(this));
					dispatchEventWithCheck(new ResizeEvent(ResizeEvent.RESIZE, oldWidth, oldHeight));
					invalidateDisplayList();
					invalidateParentSizeAndDisplayList();
				}
				//				trace("validateSize");
			}
		}
		
		/**
		 * 处理对组件设置的属性。 
		 * 
		 */		
		protected function commitProperties():void
		{
			if(_toolTipChanged)
			{
				_toolTipChanged = false;
				
				if(_toolTipControl == null)
					createChildren();
				_toolTipControl.toolTip = _toolTip;
			}
		}
		
		/**
		 * 计算组件的默认大小和（可选）默认最小大小。此方法是一种高级方法，可在创建 UIComponent 的子类时覆盖。
		 * 此方法并仅测量合适大小，并不改变实际尺寸 
		 * 
		 */		
		protected function measure():void
		{
			_measuredWidth = 0;
			_measuredHeight = 0;
		}
		
		/**
		 *  设置其子项的大小和位置。
		 *  <p>建议不要在此方法添加对对象，因为执行此方法时，正值LayoutManager执行validateDisplayList函数，如果此时添加子对象，会导致立刻执行子对象的updateDisplayList，而未执行过validateSize阶段，会导致宽/高为NaN</p>
		 * @param width 指定组件在组件坐标中的宽度
		 * @param height 指定组件在组件坐标中的高度
		 * 
		 */		
		protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			if(_autoDrawRepsonseChanged)
			{
				var g:Graphics = graphics;
				g.clear();
				if(_autoDrawRepsonse)
				{
					g.beginFill(0, 0);
					g.drawRect(0, 0, unscaleWidth, unscaleHeight);
					g.endFill();
				}
			}
		}
		
		/**
		 * 在下一帧执行 
		 * @param method 执行的方法 
		 * @param args 传入的参数
		 * 
		 */		
		public function callLater(method:Function, args:Array = null):void
		{
			if(_methodQueue == null)
				_methodQueue = new Vector.<MethodElement>();
			_methodQueue.push(new MethodElement(method, args));
			addEventListener(Event.ENTER_FRAME, callLaterHandler);
		}
		
		protected function callLaterHandler(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, callLaterHandler);
			if(_methodQueue != null)
			{
				for (var i:int = 0; i < _methodQueue.length; i++) 
				{
					_methodQueue[i].method.apply(null, _methodQueue[i].args);
				}
			}
			_methodQueue = new Vector.<MethodElement>();
		}
		/**
		 * @inheritDoc
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return addChildAt(child, numChildren); 
		}
		/**
		 * @inheritDoc
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var result:DisplayObject;
			if(child != null)
			{
				if(child is IVisualElement)
					(child as IVisualElement).depth = depth + 1;
				result = super.addChildAt(child, index);
				if(child is IVisualElement)
					invalidateSize();
			}
			return result;
		}
		/**
		 * @inheritDoc
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var result:DisplayObject =  super.removeChild(child);
			if(result && result is IVisualElement)
			{
				(result as IVisualElement).depth = 0;
				invalidateSize();
			}
			return result;
		}
		/**
		 * @inheritDoc
		 */
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			return removeChild(child);
		}
		
		final remote_internal function $addChild(child:DisplayObject):DisplayObject
		{
			return super.addChild(child);
		}
		
		final remote_internal function $addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return super.addChildAt(child, index);
		}
		
		final remote_internal function $removeChild(child:DisplayObject):DisplayObject
		{
			return super.removeChild(child);
		}
		
		final remote_internal function $removeChildAt(index:int):DisplayObject
		{
			return super.removeChildAt(index);
		}
		/**
		 * @inheritDoc
		 */
		override public function set x(value:Number):void
		{
			move(value, y);
		}
		/**
		 * @inheritDoc
		 */
		override public function set y(value:Number):void
		{
			move(x ,value);
		}
		
		/**
		 * 测量的宽度 
		 */
		remote_internal function get measuredWidth():Number
		{
			return _measuredWidth;
		}
		remote_internal function set measuredWidth(value:Number):void
		{
			_measuredWidth = value;
		}
		
		/**
		 * 测量的高度 
		 */
		remote_internal function get measuredHeight():Number
		{
			return _measuredHeight;
		}
		
		remote_internal function set measuredHeight(value:Number):void
		{
			_measuredHeight = value;
		}
		
		/**
		 * 显式设置的高度 
		 */
		remote_internal function get explicitHeight():Number
		{
			return _explicitHeight;
		}
		
		/**
		 * 显式设置的宽度 
		 */
		remote_internal function get explicitWidth():Number
		{
			return _explicitWidth;
		}
		
		/**
		 * 获取测量或者显式设置的宽度，优先返回显式设置的宽度 
		 * @return 宽度
		 * 
		 */		
		public function getExplicitOrMeasuredWidth():Number
		{
			return !isNaN(explicitWidth) ? explicitWidth : measuredWidth;
		}
		
		/**
		 * 获取测量或者显式设置的高度，优先返回显式设置的高度 
		 * @return 高度
		 * 
		 */		
		public function getExplicitOrMeasuredHeight():Number
		{
			return !isNaN(explicitHeight) ? explicitHeight : measuredHeight;
		}
		/**
		 * @inheritDoc
		 */
		public function get toolTip():String
		{
			return _toolTipControl != null?_toolTipControl.toolTip:null;
		}
		
		public function set toolTip(value:String):void
		{
			if(_toolTip != value)
			{
				_toolTip = value;
				_toolTipChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * 是否自动绘制响应区域，若为true，则绘制和width、height相同的矩形区域用于响应交互 
		 */
		public function get autoDrawRepsonse():Boolean
		{
			return _autoDrawRepsonse;
		}
		
		/**
		 * @private
		 */
		public function set autoDrawRepsonse(value:Boolean):void
		{
			if(_autoDrawRepsonse != value)
			{
				_autoDrawRepsonse = value;
				_autoDrawRepsonseChanged = true;
				invalidateDisplayList();
			}
		}
		
		/**
		 * 
		 * @private 
		 */
		public function get updateCompletePendingFlag():Boolean
		{
			return _updateCompletePendingFlag;
		}
		
		/**
		 * @private
		 */
		public function set updateCompletePendingFlag(value:Boolean):void
		{
			_updateCompletePendingFlag = value;
		}
		
		
		/**
		 * 最大测量宽度
		 * 
		 */		
		public function get maxMeasureWidth():Number
		{
			return _maxMeasureWidth;
		}
		
		public function set maxMeasureWidth(value:Number):void
		{
			if(isNaN(value))
				value = int.MAX_VALUE;
			_maxMeasureWidth = value;
		}
		
		/**
		 * 最大测量高度 
		 * 
		 */		
		public function get maxMeasureHeight():Number
		{
			return _maxMeasureHeight;
		}
		
		public function set maxMeasureHeight(value:Number):void
		{
			if(isNaN(value))
				value = int.MAX_VALUE;
			_maxMeasureHeight = value;
			invalidateSize();
		}
		
		/**
		 * 最小测量宽度 
		 */
		public function get minMeasureWidth():Number
		{
			return _minMeasureWidth;
		}
		
		/**
		 * @private
		 */
		public function set minMeasureWidth(value:Number):void
		{
			if(isNaN(value))
				value = 0;
			_minMeasureWidth = value;
		}
		
		/**
		 * 最小测量高度 
		 */
		public function get minMeasureHeight():Number
		{
			return _minMeasureHeight;
		}
		
		/**
		 * @private
		 */
		public function set minMeasureHeight(value:Number):void
		{
			if(isNaN(value))
				value = 0;
			_minMeasureHeight = value;
		}
		
		
	}
}