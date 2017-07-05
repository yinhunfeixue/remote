package remote2.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import remote2.core.IDisplayText;
	import remote2.events.CloseEvent;
	import remote2.events.RemoteEvent;
	import remote2.manager.PopUpManager;
	
	/**
	 * 警告框
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-26
	 *
	 * */
	public class Alert extends TitleWindow
	{	
		/**
		 * 在 Alert 控件上启用“是”按钮的值
		 */		
		public static const YES:uint = 1;
		
		/**
		 * 在 Alert 控件上启用“否”按钮的值
		 */		
		public static const NO:uint = 2;
		
		/**
		 * 在 Alert 控件上启用“确定”按钮的值
		 */		
		public static const OK:uint = 3;
		
		/**
		 * 在 Alert 控件上启用“取消”按钮的值
		 */		
		public static const CANCEL:uint= 4;
		
		/**
		 * “是”按钮的标签
		 */		
		public static var yesLabel:String = "是";
		
		/**
		 * “否”按钮的标签
		 */		
		public static var noLabel:String = "否";
		
		/**
		 *  “确定”按钮的标签
		 */		
		public static var okLabel:String = "确定";
		
		/**
		 * “取消”按钮的标签
		 */		
		public static var cancelLabel:String = "取消";
		
				
		/**
		 * 弹出 Alert 控件的静态方法
		 * @param text 在 Alert 控件中显示的文本字符串。
		 * @param title 标题栏中显示的文本字符串
		 * @param buttonValues  Alert 控件中放置的按钮的值，可以使用 Alert.OK、Alert.CANCEL、Alert.YES 和 Alert.NO,也可以自定义值
		 * 默认是Alert.OK
		 * @param closeHandler 按下 Alert 控件上的任意按钮时将调用的事件处理函数。传递给此处理函数的事件对象是 CloseEvent 的一个实例；此对象的 detail 属性包含按钮 buttonValues中对应的值
		 * @param iconClass 图标类型
		 * @param buttonLabels 按钮上显示的文字，和buttonValues一一对应，若buttonValues中未使用自定义值，此参数可以使用null
		 * @param modal 是否以模式方式弹出
		 * @return 弹出的Alert
		 * 
		 */		
		public static function show(text:String, title:String = "",
									buttonValues:Array = null,
									closeHandler:Function = null,
									iconClass:Class = null,
									buttonLabels:Array = null,
									modal:Boolean = true):Alert
		{
			if(buttonValues == null)
			{
				buttonValues = [OK];
			}
			if(buttonLabels == null)
			{
				buttonLabels = [];
				for(var i:int = 0; i < buttonValues.length; i++)
				{
					var label:String = valueToLabel(buttonValues[i]);
					buttonLabels.push(label);
				}
			}
			var alert:Alert = new Alert();
			alert.text = text;
			alert.title = title;
			alert.iconClass = iconClass;
			alert.buttonValues = buttonValues;
			alert.buttonLabels = buttonLabels;
			alert.closeHandler = closeHandler;
			alert.modal = modal;
			alert.show();
			return alert;
		}
		
		private static function valueToLabel(value:int):String
		{
			switch(value)
			{
				case YES:
					return yesLabel;
				case NO:
					return noLabel;
				case OK:
					return okLabel;
				case CANCEL:
					return cancelLabel;
				default:
					return "";
			}
		}
		
		
		private var _text:String;
		private var _textChanged:Boolean;
		
		private var _iconClass:Class;
		private var _iconClassChanged:Boolean;
		
		private var _buttonValues:Array;
		
		private var _buttonLabels:Array;
		
		private var _closeHandler:Function;
		
		private var _buttons:Array;
		
		private var _buttonChanged:Boolean;
		
		/**
		 * 是否模式窗口 
		 */		
		public var modal:Boolean = true;
		
		/**
		 * 显示内容的文本控件
		 * 
		 */		
		protected function get labelDisplay():IDisplayText
		{
			return findSkinPart("labelDisplay");
		}
		
		/**
		 * 显示图标的控件 
		 * 
		 */		
		protected function get imageIcon():Image
		{
			return findSkinPart("imageIcon", false);
		}
		
		/**
		 * 放置按钮的容器 
		 * 
		 */		
		protected function get groupButtons():Group
		{
			return findSkinPart("groupButtons");
		}
		
		/**
		 * 实例化 
		 * 
		 */		
		public function Alert()
		{
			super();
			minMeasureHeight = 100;
			minMeasureWidth = 30;
			addEventListener(CloseEvent.CLOSE, this_closeHandler);
		}
		
		/**
		 * 显示 
		 * 
		 */		
		public function show():void
		{
			PopUpManager.addPopUp(this, modal);
			PopUpManager.centerPopUp(this);
		}
		
		/**
		 * @private 
		 */		
		protected function this_closeHandler(event:Event):void
		{
			if(_closeHandler != null)
			{
				_closeHandler(event);
			}
		}
		/**
		 * @private 
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_textChanged)
			{
				_textChanged = false;
				labelDisplay.text = _text;
			}
			if(_iconClassChanged)
			{
				_iconClassChanged = false;
				if(imageIcon)
					imageIcon.source = _iconClass;
			}
			if(_buttonChanged)
			{
				_buttonChanged = false;
				updateButton();
			}
		}
		
		private function updateButton():void
		{
			groupButtons.removeAllChildren();
			_buttons = [];
			for(var i:int = 0; i < _buttonValues.length; i++)
			{
				if(i < _buttonLabels.length)
				{
					var button:Button = new Button();
					button.addEventListener(MouseEvent.CLICK, button_clickHandler);
					button.label = _buttonLabels[i];
					_buttons.push(button);
					groupButtons.addChild(button);
				}
			}
		}
		
		private function removeAlert(value:int):void
		{
			PopUpManager.removePopUp(this);
			var event:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
			event.detail = value;
			dispatchEvent(event);
		}
		/**
		 * @private 
		 */	
		protected function button_clickHandler(event:MouseEvent):void
		{
			var index:int = _buttons.indexOf(event.target);
			var detail:int = -1;
			if(index >= 0)
				detail = _buttonValues[index];
			removeAlert(detail);
		}
		
		/**
		 * 关闭处理函数，参数为CloseEvent实例
		 * 
		 * @see remote2.events.CloseEvent
		 */
		public function get closeHandler():Function
		{
			return _closeHandler;
		}
		
		/**
		 * @private
		 */
		public function set closeHandler(value:Function):void
		{
			_closeHandler = value;
		}
		
		/**
		 * 按钮标签文字 
		 */
		public function get buttonLabels():Array
		{
			return _buttonLabels;
		}
		
		/**
		 * @private
		 */
		public function set buttonLabels(value:Array):void
		{
			_buttonLabels = value;
			_buttonChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 按钮值
		 */
		public function get buttonValues():Array
		{
			return _buttonValues;
		}
		
		/**
		 * @private
		 */
		public function set buttonValues(value:Array):void
		{
			_buttonValues = value;
			_buttonChanged = true;
			invalidateProperties();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			_textChanged = true;
			invalidateProperties();
		}
		
		/**
		 * 图标类型 
		 */
		public function get iconClass():Class
		{
			return _iconClass;
		}
		
		/**
		 * @private
		 */
		public function set iconClass(value:Class):void
		{
			_iconClass = value;
			_iconClassChanged = true;
			invalidateProperties();
		}
		
		
	}
}