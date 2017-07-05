package modules.canvas
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import remote2.collections.ArrayCollection;
	import remote2.components.Group;
	import remote2.components.UIComponent;
	
	
	/**
	 * 标尺 
	 * @author xujunjie
	 * 
	 */	
	public class Scaleplate extends Group
	{
		
		private var _horRule:UIComponent;
		private var _verRule:UIComponent;
		/**
		 * 单位长度，每一刻度的距离 
		 */		
		private var _unitlength:uint = 5;
		
		private var _horizontalLineArr:ArrayCollection = new ArrayCollection();
		private var _vertercalLineArr:ArrayCollection = new ArrayCollection();
		private var _currentLine:ScaleplateLine;
		
		private var _groupContent:Group;
		
		public function Scaleplate()
		{
			super();
			mouseEnabled = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_horRule = new UIComponent();
			_horRule.buttonMode = true;
			_horRule.x = empty;
			_horRule.height = 20;
			_horRule.addEventListener(MouseEvent.MOUSE_DOWN, horRule_mouseDownHandler);
			_verRule = new UIComponent();
			_verRule.buttonMode = true;
			_verRule.y = empty;
			_verRule.width = 20;
			_verRule.addEventListener(MouseEvent.MOUSE_DOWN, verRule_mouseDownHandler);
			addChild(_horRule);
			addChild(_verRule);
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			if(event.target is ScaleplateLine)
			{
				_currentLine = event.target as ScaleplateLine;
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
		}
		
		protected function verRule_mouseDownHandler(event:MouseEvent):void
		{
			if(stage)
			{
				if(_currentLine != null)
					removeChild(_currentLine);
				_currentLine = new ScaleplateLine();
				_currentLine.direction = 1;
				_currentLine.percentHeight = 100;
				_currentLine.width = 0;
				_currentLine.x = _groupContent.mouseX;
				addLine(_currentLine);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
		}
		
		protected function horRule_mouseDownHandler(event:MouseEvent):void
		{
			if(stage)
			{
				if(_currentLine != null)
					removeChild(_currentLine);
				_currentLine = new ScaleplateLine();
				_currentLine.direction = 0;
				_currentLine.percentWidth = 100;
				_currentLine.height = 0;
				_currentLine.y = _groupContent.mouseY;
				addLine(_currentLine);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
		}
		
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			if(_currentLine != null)
			{
				if(_currentLine.direction == 0)
					_currentLine.y = _groupContent.mouseY;
				else
					_currentLine.x = _groupContent.mouseX;
			}
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			if(_currentLine != null)
			{
				if(_currentLine.direction == 0)
				{
					if(_currentLine.y < 0 || _currentLine.y > height - empty)
					{
						removeLine(_currentLine);
					}
				}
				else if(_currentLine.x < 0 || _currentLine.x > width - empty)
				{
					removeLine(_currentLine);
				}
				_currentLine = null;
			}
			removeAddLineListener();
		}
		
		private function removeAddLineListener():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function drawUnitLength():void
		{
			var w:int, h:int, index:int, lineBackgroundColor:uint = 0xeeeeee;
			var g:Graphics = _horRule.graphics;
			g.clear();
			g.lineStyle(1, 0);
			//先画横向的
			g.beginFill(lineBackgroundColor);
			g.drawRect(0, 0, _horRule.width, _horRule.height);
			g.endFill();
			for(w = 0; w < _horRule.width; w+=_unitlength)
			{
				g.moveTo(w, 0);
				g.lineTo(w, index % 5 == 0?20:10);
				index++;
			}
			index = 0;
			g = _verRule.graphics;
			g.clear();
			g.lineStyle(1, 0);
			g.beginFill(lineBackgroundColor);
			g.drawRect(0, 0, _verRule.width, _verRule.height);
			g.endFill();
			//画纵向的
			for(h = 0; h < _verRule.height; h+=_unitlength)
			{
				g.moveTo(0, h);
				g.lineTo(index % 5 == 0?20:10, h);
				index++;
			}
		}
		
		public function removeAllLine():void
		{
			
		}
		
		public function removeLine(line:ScaleplateLine):void
		{
			if(_groupContent && _groupContent.contains(line))
				_groupContent.removeChild(line);
			_horizontalLineArr.removeItem(line);
			_vertercalLineArr.removeItem(line);
		}
		
		public function addLine(line:ScaleplateLine):void
		{
			if(line.direction == 0)
			{
				if(_horizontalLineArr.getItemIndex(line) < 0)
					_horizontalLineArr.addItem(line);

			}
			else
			{
				if(_vertercalLineArr.getItemIndex(line) < 0)
					_vertercalLineArr.addItem(line);
			}
			_groupContent.addChild(line);
		}
		
		
		public function get empty():uint
		{
			return 20;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			_horRule.width = unscaledWidth - empty;
			_verRule.height = unscaledHeight - empty;
			drawUnitLength();
		}

		public function get groupContent():Group
		{
			return _groupContent;
		}

		public function set groupContent(value:Group):void
		{
			if(_groupContent)
			{
				_groupContent.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				removeAllLine();
			}
			_groupContent = value;
			if(_groupContent)
			{
				_groupContent.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
		}

	}
}