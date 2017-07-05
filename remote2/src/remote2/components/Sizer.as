package remote2.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import remote2.enums.Direction;
	
	/**
	 * 调整其它显示对象的尺寸的控件。
	 *
	 * @author xujunjie
	 * @date 2013-5-26 下午4:21:04
	 * 
	 */	
	public class Sizer extends SkinnableComponent
	{
		
		protected function get buttonTopLeft():Button
		{
			return findSkinPart("buttonTopLeft");
		}
		protected function get buttonTopCenter():Button
		{
			return findSkinPart("buttonTopCenter");
		}
		protected function get buttonTopRight():Button
		{
			return findSkinPart("buttonTopRight");
		}
		protected function get buttonMiddleLeft():Button
		{
			return findSkinPart("buttonMiddleLeft");
		}
		protected function get buttonMiddleRight():Button
		{
			return findSkinPart("buttonMiddleRight");
		}
		protected function get buttonBottomLeft():Button
		{
			return findSkinPart("buttonBottomLeft");
		}
		protected function get buttonBottomCenter():Button
		{
			return findSkinPart("buttonBottomCenter");
		}
		protected function get buttonBottomRight():Button
		{
			return findSkinPart("buttonBottomRight");
		}
		/**
		 * 开始拖动时，相对于舞台的尺寸和位置 
		 */		
		private var _dragRectangle:Rectangle;
		private var _dragRectangleChanged:Boolean;
		
		private var _target:DisplayObject;
		private var _targetChanged:Boolean;
		
		private var _xDir:int;
		private var _yDir:int;
		
		private var _enabledChanged:Boolean;
		
		
		public function Sizer()
		{
			super();
			includeInLayout = false;
			autoDrawRepsonse = false;
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			var target:Object = event.target;
			switch(target)
			{
				case buttonTopLeft:
					_xDir = Direction.LEFT;
					_yDir = Direction.UP;
					addStageListener();
					break;
				case buttonTopCenter:
					_xDir = Direction.UNKNOW;
					_yDir = Direction.UP
					addStageListener();
					break;
				case buttonTopRight:
					_xDir = Direction.RIGHT;
					_yDir = Direction.UP;
					addStageListener();
					break;
				case buttonMiddleLeft:
					_xDir = Direction.LEFT;
					_yDir = Direction.UNKNOW;
					addStageListener();
					break;
				case buttonMiddleRight:
					_xDir = Direction.RIGHT;
					_yDir = Direction.UNKNOW;
					addStageListener();
					break;
				case buttonBottomLeft:
					_xDir = Direction.LEFT;
					_yDir = Direction.DOWN;
					addStageListener();
					break;
				case buttonBottomCenter:
					_xDir = Direction.UNKNOW;
					_yDir = Direction.DOWN;
					addStageListener();
					break;
				case buttonBottomRight:
					_xDir = Direction.RIGHT;
					_yDir = Direction.DOWN;
					addStageListener();
					break;
			}
		}
		
		private function addStageListener():void
		{
			var point:Point = localToGlobal(new Point());
			_dragRectangle = new Rectangle(point.x, point.y, width, height);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			removeStageListener();
			_xDir = _yDir = Direction.UNKNOW;
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void
		{
			var newX:Number, newY:Number;
			switch(_xDir)
			{
				case Direction.LEFT:
					newX = stage.mouseX;
					_dragRectangle.left = newX;
					invalidateDragRectangle();
					break;
				case Direction.RIGHT:
					newX = stage.mouseX;
					_dragRectangle.right = newX;
					invalidateDragRectangle();
					break;
			}
			switch(_yDir)
			{
				case Direction.UP:
					newY = stage.mouseY;
					_dragRectangle.top = newY;
					invalidateDragRectangle();
					break;
				case Direction.DOWN:
					newY = stage.mouseY;
					_dragRectangle.bottom = newY;
					invalidateDragRectangle();
					break;
			}
		}
		
		private function removeStageListener():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		private function invalidateDragRectangle():void
		{
			_dragRectangleChanged = true;
			invalidateProperties();
		}
		
		/**
		 * only be false
		 * @private
		 */		
		override public function set includeInLayout(value:Boolean):void
		{
			super.includeInLayout = false;
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			buttonTopCenter.x = Math.round(unscaleWidth / 2);
			buttonTopRight.x = Math.round(unscaleWidth);
			
			buttonMiddleLeft.y = Math.round(unscaleHeight / 2);
			
			buttonMiddleRight.y = Math.round(unscaleHeight / 2);
			buttonMiddleRight.x = Math.round(unscaleWidth);
			
			buttonBottomCenter.y = buttonBottomLeft.y = buttonBottomRight.y = Math.round(unscaleHeight);
			
			buttonBottomCenter.x = Math.round(unscaleWidth / 2);
			buttonBottomRight.x = Math.round(unscaleWidth);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_targetChanged)
			{
				_targetChanged = false;
				if(_target)
				{
					super.width = _target.width;
					super.height = _target.height;
					super.x = _target.x;
					super.y = _target.y;
				}
			}
			if(_dragRectangleChanged)
			{
				_dragRectangleChanged = false;
				
				var newRectangle:Rectangle = _dragRectangle.clone();
				//矩形调整为正矩形（right小于left,则交换值; bottom小于top，则交换值）
				if(newRectangle.left > newRectangle.right)
				{
					var left:Number = newRectangle.right;
					newRectangle.right = newRectangle.left;
					newRectangle.left = left;
				}
				if(newRectangle.top > newRectangle.bottom)
				{
					var top:Number = newRectangle.bottom;
					newRectangle.bottom = newRectangle.top;
					newRectangle.top = top;
				}
				
				var newPoint:Point = new Point(newRectangle.x, newRectangle.y);
				newPoint = parent.globalToLocal(newPoint);
				super.x = newPoint.x;
				super.y = newPoint.y;
				super.width = newRectangle.width;
				super.height = newRectangle.height;
				if(_target)
				{
					_target.x = x;
					_target.y = y;
					_target.width = width;
					_target.height = height;
				}
			}
			if(_enabledChanged)
			{
				_enabledChanged = false;
				buttonBottomCenter.visible = enabled;
				buttonBottomLeft.visible = enabled;
				buttonBottomRight.visible = enabled;
				buttonMiddleLeft.visible = enabled;
				buttonMiddleRight.visible = enabled;
				buttonTopCenter.visible = enabled;
				buttonTopLeft.visible = enabled;
				buttonTopRight.visible = enabled;
			}
		}
		
		/**
		 * 设置是否可用。若不可用，所有调节按钮不可见 
		 * 
		 */		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = true;
			_enabledChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 用于调整的目标对象
		 * 
		 */		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target(value:DisplayObject):void
		{
			_target = value;
			_targetChanged = true;
			if(_target == null)
			{
				if(parent)
					parent.removeChild(this);
			}
			else if(_target && _target.parent)
				_target.parent.addChild(this);
			invalidateProperties();
		}
		
	}
}