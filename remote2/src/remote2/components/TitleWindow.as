package remote2.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import remote2.core.IPopUp;
	import remote2.core.remote_internal;
	import remote2.enums.SizeStateEnum;
	import remote2.events.CloseEvent;
	
	use namespace remote_internal;
	
	[Event(name="close", type="remote2.events.CloseEvent")]
	
	[SkinState("normalAndMini")]
	[SkinState("normalAndMax")]
	[SkinState("disabledAndMini")]
	[SkinState("disabledAndMax")]
	/**
	 * 带标题的窗口
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class TitleWindow extends SkinnableComponent implements IPopUp
	{
		
		/**
		 * @private 
		 * 
		 */		
		protected function get buttonClose():Button
		{
			return findSkinPart("buttonClose", false);
		}
		
		/**
		 * 最小化/最大化 
		 * @private
		 */		
		protected function get buttonSize():ToggleButton
		{
			return findSkinPart("buttonSize", false);
		}
		/**
		 * @private 
		 * 
		 */
		protected function get labelTitle():RichText
		{
			return findSkinPart("labelTitle", false);
		}
		/**
		 * @private 
		 * 
		 */
		protected function get moveArea():DisplayObject
		{
			return findSkinPart("moveArea");
		}
		
		private var _title:String;
		private var _titleChanged:Boolean;
		
		private var _isPopup:Boolean;
		
		/**
		 * 尺寸状态 
		 */		
		private var _sizeState:int = SizeStateEnum.NORMAL;
		
		/**
		 * 开始拖动时，窗口的位置
		 */		
		private var _mouseDownPoint:Point;
		
		/**
		 * 开始拖动时，光标的全局位置 
		 */		
		private var _mouseDownMousePoint:Point;
		
		private var _sizeControlEnable:Boolean = true;
		
		private var _closeControlEnable:Boolean = true;
		
		private var _controlSettingChanged:Boolean = false;
		
		public var contentGroup:Group;
		
		public function TitleWindow()
		{
			super();
			contentGroup = new Group();
			addChild(contentGroup);
		}
		
		override protected function getCurrentState():String
		{
			var state:String = super.getCurrentState();
			switch(_sizeState)
			{
				case SizeStateEnum.MINI:
					state += "AndMini";
					break;
				case SizeStateEnum.MAX:
					state += "AndMax";
					break;
			}
			return state;
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			if(buttonClose)
				buttonClose.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
			if(moveArea)
				moveArea.addEventListener(MouseEvent.MOUSE_DOWN, moveArea_mouseDownHandler);
			if(buttonSize)
				buttonSize.addEventListener(Event.CHANGE, sizeButton_changeHandler);
		}
		
		override protected function onSkinRemoveing():void
		{
			if(buttonClose)
				buttonClose.removeEventListener(MouseEvent.CLICK, closeButton_clickHandler);
			if(moveArea)
				moveArea.removeEventListener(MouseEvent.MOUSE_DOWN, moveArea_mouseDownHandler);
			if(buttonSize)
				buttonSize.removeEventListener(Event.CHANGE, sizeButton_changeHandler);
			super.onSkinRemoveing();
		}
		
		protected function sizeButton_changeHandler(event:Event):void
		{
			if(_sizeState == SizeStateEnum.NORMAL)
				_sizeState = SizeStateEnum.MINI;
			else
				_sizeState = SizeStateEnum.NORMAL;
			validateSkinState();
		}
		
		protected function moveArea_mouseDownHandler(event:Event):void
		{
			if(_isPopup && stage)
			{
				_mouseDownPoint = new Point(x, y);
				_mouseDownMousePoint = new Point(stage.mouseX, stage.mouseY);
				includeInLayout = false;
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_moveHandler);
			}
		}
		
		protected function stage_moveHandler(event:MouseEvent):void
		{
			var currentPoint:Point = new Point(stage.mouseX, stage.mouseY).subtract(_mouseDownMousePoint).add(_mouseDownPoint);
			move(Math.round(currentPoint.x), Math.round(currentPoint.y));
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			if(stage)
			{
				_mouseDownPoint = null;
				includeInLayout = true;
				stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_moveHandler);
			}
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_titleChanged)
			{
				_titleChanged = false;
				if(labelTitle)
					labelTitle.text = _title;
			}
			if(_controlSettingChanged)
			{
				_controlSettingChanged = false;
				if(buttonClose)
					buttonClose.visible = _closeControlEnable;
				if(buttonSize)
					buttonSize.visible = _sizeControlEnable;
			}
		}

		/**
		 * 标题文字 
		 */
		public function get title():String
		{
			return _title;
		}

		/**
		 * @private
		 */
		public function set title(value:String):void
		{
			if(_title != value)
			{
				_title = value;
				_titleChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * 向内容区添加子对象，和addChild不同。
		 * @param child 要添加的子对象
		 * @return 在 child 参数中传递的 DisplayObject 实例。
		 * 
		 */		
		public function addContent(child:DisplayObject):DisplayObject
		{
			return contentGroup.addChild(child);
		}
		
		/**
		 * 向内容区添加子对象
		 * @param child 要添加的子对象
		 * @param index 添加该子项的索引位置。
		 * @return 在 child 参数中传递的 DisplayObject 实例。
		 * 
		 */		
		public function addContentAt(child:DisplayObject, index:int):DisplayObject
		{
			return contentGroup.addChildAt(child, index);
		}
		
		/**
		 * 移除内容区的子对象 
		 * @param child 要移除的子对象
		 * @return 
		 * 
		 */		
		public function removeContent(child:DisplayObject):DisplayObject
		{
			return contentGroup.removeChild(child);
		}
		
		/**
		 * 移除内容区的子对象 
		 * @param index 子项的索引位置。
		 * @return 
		 * 
		 */		
		public function removeContentAt(index:int):DisplayObject
		{
			return contentGroup.removeChildAt(index);
		}
		
		/**
		 * 移除内容区所有子对象 
		 * 
		 */		
		public function removeAllContent():void
		{
			while(contentGroup.numChildren > 0)
			{
				contentGroup.removeChildAt(0);
			}
		}

		/**
		 * 是否是弹出状态，如果为true,会开启鼠标拖动功能 
		 */
		public function get isPopup():Boolean
		{
			return _isPopup;
		}

		/**
		 * @private
		 */
		public function set isPopup(value:Boolean):void
		{
			_isPopup = value;
		}

		/**
		 * 是否显示最大化/最小化按钮 
		 */
		public function get sizeControlEnable():Boolean
		{
			return _sizeControlEnable;
		}

		/**
		 * @private
		 */
		public function set sizeControlEnable(value:Boolean):void
		{
			_sizeControlEnable = value;
			_controlSettingChanged = true;
			invalidateProperties();
		}

		/**
		 * 是否显示关闭按钮 
		 */
		public function get closeControlEnable():Boolean
		{
			return _closeControlEnable;
		}

		/**
		 * @private
		 */
		public function set closeControlEnable(value:Boolean):void
		{
			_closeControlEnable = value;
			_controlSettingChanged = true;
			invalidateProperties();
		}

		
	}
}