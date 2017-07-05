package remote2.components.supports
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import remote2.components.SkinnableComponent;
	import remote2.core.BaseTextFormatData;
	import remote2.core.IBaseTextFormat;
	import remote2.core.IDisplayLabel;
	import remote2.core.IDisplayText;
	import remote2.core.remote_internal;
	import remote2.events.RemoteEvent;
	
	use namespace remote_internal;
	
	[SkinState("disabled")]
	[SkinState("down")]
	[SkinState("over")]
	[SkinState("up")]
	
	[Event(name="buttonDown", type="remote2.events.RemoteEvent")]
	/**
	 * 按钮基类
	 * 定义了按钮的基本状态的事件控制
	 * 没有文本相关接口 
	 * @author xujunjie
	 * 
	 */	
	public class ButtonBase extends SkinnableComponent implements IBaseTextFormat, IDisplayLabel
	{
		
		/**
		 * 文本组件 
		 * no requisite 
		 * 
		 */		
		protected function get labelDisplay():IDisplayText
		{
			return findSkinPart("labelDisplay", false);
		}
		
		
		private var _label:String;
		private var _labelChanged:Boolean;
		
		private var _hovered:Boolean;
		private var _mouseCaptured:Boolean;
		
		private var _autoRepeatTimer:Timer;
		
		private var _repeatInterval:Number = 50;
		
		private var _autoRepeat:Boolean = false;
		
		private var _baseTextFormat:BaseTextFormatData;
		private var _baseTextFormatChanged:Boolean;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ButtonBase()
		{
			super();
			mouseChildren = false;
			_hovered = false;
			_mouseCaptured = false;
			useHandCursor = true;
			_baseTextFormat = new BaseTextFormatData();
			addHandlers();
		}
		
		private function addHandlers():void
		{
			addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler);
			addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
			addEventListener(MouseEvent.CLICK, mouseEventHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
		}
		
		protected function removeFromStageHandler(event:Event):void
		{
			hovered = false;
			mouseCaptured = false;
		}
		
		private function checkAutoRepeat():void
		{
			if(isDown())
			{
				if(_autoRepeatTimer == null || !_autoRepeatTimer.running)
					startRepeatTimer();
			}
			else
				stopRepeatTimer();
		}
		
		private function startRepeatTimer():void
		{
			if(_autoRepeatTimer == null)
				_autoRepeatTimer = new Timer(_repeatInterval);
			_autoRepeatTimer.addEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
			_autoRepeatTimer.start();
		}
		
		protected function autoRepeatTimer_timerHandler(event:TimerEvent):void
		{
			if(_autoRepeat && isDown())
			{
				if(_autoRepeatTimer.currentCount >= 2)
					dispatchEvent(new RemoteEvent(RemoteEvent.BUTTON_DOWN));
			}
			else
				stopRepeatTimer();
		}
		
		private function isDown():Boolean
		{
			return enabled && mouseCaptured && hovered;
		}
		
		private function stopRepeatTimer():void
		{
			if(_autoRepeatTimer)
			{
				_autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
				_autoRepeatTimer.reset();
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_labelChanged && labelDisplay != null)
			{
				_labelChanged = false;
				labelDisplay.text = _label;
			}
			if(_baseTextFormatChanged && labelDisplay)
			{
				_baseTextFormatChanged = false;
				if(labelDisplay is IBaseTextFormat)
					_baseTextFormat.fill(labelDisplay as IBaseTextFormat);
			}
		}
		
		private function invalidateBaseTextFormat():void
		{
			_baseTextFormatChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 鼠标处理事件 
		 * @param event
		 * 
		 */		
		protected function mouseEventHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.ROLL_OVER:
				{
					if (event.buttonDown && !_mouseCaptured)
						return;
					hovered = true;
					break;
				}
				case MouseEvent.ROLL_OUT:
				{
					hovered = false;
					break;
				}
				case MouseEvent.MOUSE_DOWN:
				{
					mouseCaptured = true;
					addSystemMouseHandlers();
					dispatchEvent(new RemoteEvent(RemoteEvent.BUTTON_DOWN));
					break;
				}
				case MouseEvent.MOUSE_UP:
				{
					mouseCaptured = false;
					hovered = true;
					break;
				}
				case MouseEvent.CLICK:
				{
					if(!enabled)
						event.stopImmediatePropagation();
					break;
				}
			}
		}
		
		private function addSystemMouseHandlers():void
		{
			stage.addEventListener(
				MouseEvent.MOUSE_UP, systemManager_mouseUpHandler);
		}
		
		private function removeSystemMouseHandlers():void
		{
			stage.removeEventListener(
				MouseEvent.MOUSE_UP, systemManager_mouseUpHandler);
		}
		
		protected function systemManager_mouseUpHandler(event:MouseEvent):void
		{
			if(event.target == this)
				return;
			hovered = false;
			mouseCaptured = false;
		}
		/**
		 * @inheritDoc
		 */	
		override protected function getCurrentState():String
		{
			if (!enabled)
				return "disabled";
			if (mouseCaptured && hovered)
				return "down";
			if (hovered)
				return "over";
			return "up";
		}
		/**
		 * 鼠标是否是移上状态 
		 * 
		 */		
		protected function get hovered():Boolean
		{
			return _hovered;
		}
		
		protected function set hovered(value:Boolean):void
		{
			_hovered = value;
			validateSkinState();
			checkAutoRepeat();
		}
		
		/**
		 * 鼠标是否是按下状态 
		 * 
		 */		
		protected function get mouseCaptured():Boolean
		{
			return _mouseCaptured;
		}
		
		protected function set mouseCaptured(value:Boolean):void
		{
			if(!value)
			{
				removeSystemMouseHandlers();
			}
			_mouseCaptured = value;
			validateSkinState();
			checkAutoRepeat();
		}
		/**
		 * @inheritDoc
		 */	
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			checkAutoRepeat();
		}
		
		
		/**
		 * 按钮上显示的文字 
		 * @return 
		 * 
		 */		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(_label != value)
			{
				_label = value;
				_labelChanged = true;
				invalidateProperties();
				invalidateSize();
			}
		}
		
		/**
		 * 是否自动重复 mouseDown
		 */
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		
		/**
		 * @private
		 */
		public function set autoRepeat(value:Boolean):void
		{
			if(_autoRepeat != value)
			{
				_autoRepeat = value;
				checkAutoRepeat();
			}
		}
		
		/**
		 * 自动重复buttonDown事件的间隔 
		 */
		public function get repeatInterval():Number
		{
			return _repeatInterval;
		}
		
		/**
		 * @private
		 */
		public function set repeatInterval(value:Number):void
		{
			if(_repeatInterval != value)
			{
				_repeatInterval = value;
				stopRepeatTimer();
				checkAutoRepeat();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get align():String
		{
			return _baseTextFormat.align;
		}
		
		public function set align(value:String):void
		{
			_baseTextFormat.align = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get bold():Boolean
		{
			return _baseTextFormat.bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_baseTextFormat.bold = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get color():uint
		{
			return _baseTextFormat.color;
		}
		
		public function set color(value:uint):void
		{
			_baseTextFormat.color = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontFamily():String
		{
			return _baseTextFormat.fontFamily;
		}
		
		public function set fontFamily(value:String):void
		{
			_baseTextFormat.fontFamily = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get fontSize():Number
		{
			return _baseTextFormat.fontSize;
		}
		
		public function set fontSize(value:Number):void
		{
			_baseTextFormat.fontSize = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get italic():Boolean
		{
			return _baseTextFormat.italic;
		}
		
		public function set italic(value:Boolean):void
		{
			_baseTextFormat.italic = value;
			invalidateBaseTextFormat();
		}
		/**
		 * @inheritDoc
		 */	
		public function get underline():Boolean
		{
			return _baseTextFormat.underline;
		}
		
		public function set underline(value:Boolean):void
		{
			_baseTextFormat.underline = value;
			invalidateBaseTextFormat();
		}
	}
}