package remote2.components.supports
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import remote2.collections.RangData;
	import remote2.components.Button;
	import remote2.components.SkinnableComponent;
	import remote2.core.remote_internal;
	import remote2.events.RemoteEvent;
	
	use namespace remote_internal;
	[Event(name="change", type="flash.events.Event")]
	/**
	 * 滑块基类
	 * 在子类中需要重写pointToValue,valueToPoint 
	 * @author yinhunfeixue
	 * 
	 */	
	public class SliderBase extends SkinnableComponent
	{
		/**
		 *  滑块按钮
		 * required
		 */		
		protected function get thumb():Button
		{
			return findSkinPart("thumb");
		}
		
		/**
		 * 轨道 
		 * required
		 */		
		protected function get track():Button
		{
			return findSkinPart("track");
		}
		
		private var _data:RangData;
		private var _dataChanged:Boolean;
		private var _thumbChanged:Boolean;
		
		private var _stepSize:Number;
		
		/**
		 *  有效的步进值
		 */		
		protected var effectStepSize:Number;
		
		private var _mouseDownPoint:Point;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function SliderBase()
		{
			super();
			_data = new RangData();
			minimum = 0;
			maximum = 100;
			value = 0;
			stepSize = 1;
		}
		
		override protected function onSkinAdded():void
		{
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
			track.addEventListener(MouseEvent.CLICK, track_clickHandler);
		}
		
		protected function track_clickHandler(event:MouseEvent):void
		{
			var tempValue:Number = pointToValue(new Point(track.mouseX, track.mouseY));
			if(tempValue != value)
				value = tempValue;
		}
		
		protected function thumb_mouseDownHandler(event:MouseEvent):void
		{
			if(stage)
			{
				if(thumb)
					_mouseDownPoint = new Point(thumb.mouseX, thumb.mouseY);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			}
		}
		
		protected function removeFromStageHandler(event:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			_mouseDownPoint = null;
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_mouseDownPoint = null;
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void
		{
			var tempValue:Number = pointToValue(track.globalToLocal(new Point(event.stageX, event.stageY).subtract(_mouseDownPoint)));
			if(tempValue != value)
				value = tempValue;
		}
		
		override protected function onSkinRemoveing():void
		{
			if(thumb)
				thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
			if(track)
				track.removeEventListener(MouseEvent.CLICK, track_clickHandler);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataChanged)
			{
				_dataChanged = false;
				_data.adjust();
				effectStepSize = _stepSize;
				if(effectStepSize > (maximum - minimum))
					effectStepSize = maximum - minimum;
				if(effectStepSize <= 0)
					effectStepSize = 1;
				if(minimum == maximum)
					thumb.visible = false;
				else
					thumb.visible = true;
			}
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			if(_thumbChanged && thumb)
			{
				var pos:Point = valueToPoint();
				_thumbChanged = false;
				thumb.move(pos.x, pos.y);
			}
		}
		
		/**
		 * 根据当前值获取对应本地鼠标点（滑块的正确位置）
		 * <br/>
		 * <b>需要重写</b>
		 * @return 本地鼠标点
		 *  
		 */		
		protected function valueToPoint():Point
		{
			return new Point();
		}
		
		/**
		 * 根据鼠标点获取当前值
		 * <br/>
		 * <b>需要重写</b>
		 * <br/>
		 * 此方法需要根据stepSize计算，当前值一般是stepSize的整数倍，因此和valueToPoint方法并不是完全对应的
		 * 
		 * @param point 本地坐标系中的点
		 * @return 计算的当前值
		 * 
		 */		
		protected function pointToValue(point:Point):Number
		{
			return 0;
		}
		
		/**
		 * 当前值 
		 * 
		 */		
		public function get value():Number
		{
			return _data.value;
		}
		
		public function set value(newValue:Number):void
		{
			if(_data.value != newValue)
			{
				_data.value = newValue;
				_dataChanged = true;
				invalidateProperties();
				
				_thumbChanged = true;
				invalidateDisplayList();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		/**
		 * 最大值 
		 * 
		 */		
		public function get maximum():Number
		{
			return _data.maximum;
		}
		
		public function set maximum(value:Number):void
		{
			if(_data.maximum != value)
			{
				_data.maximum = value;
				_dataChanged = true;
				invalidateProperties();
				
				_thumbChanged = true;
				invalidateDisplayList();
			}
		}
		
		/**
		 * 最小值 
		 * 
		 */		
		public function get minimum():Number
		{
			return _data.minimum;
		}
		
		public function set minimum(value:Number):void
		{
			if(_data.minimum != value)
			{
				_data.minimum = value;
				_dataChanged = true;
				invalidateProperties();
				
				_thumbChanged = true;
				invalidateDisplayList();
				
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		/**
		 * 步进值，需要大于等于0，小于maximum - minimum
		 * @default 1 
		 */
		public function get stepSize():Number
		{
			return _stepSize;
		}
		
		/**
		 * @private
		 */
		public function set stepSize(value:Number):void
		{
			_stepSize = value;
		}
		
	}
}