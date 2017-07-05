package modules.canvas
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import remote2.collections.ArrayCollection;
	import remote2.components.Group;
	import remote2.components.Label;
	import remote2.components.Sizer;
	import remote2.components.SkinnableComponent;
	import remote2.components.UIComponent;
	import remote2.events.DragEvent;
	import remote2.events.MoveEvent;
	import remote2.events.ResizeEvent;
	import remote2.manager.DragManager;
	import remote2.utils.ClassUtil;
	
	
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * 组件画布
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class CodeCanvas extends SkinnableComponent
	{
		private var _rootComponent:UIComponent;	//根组件
		private var _rootHolder:Holder;
		
		protected var scaleplate:Scaleplate;		//标尺
		
		protected var groupContent:Group;			//存放内容的容器，X,Y和scaleplate的empty属性有关
		
		protected var labelCoor:Label;				//显示选中组件的坐标
		
		private var _selectedComponentArr:ArrayCollection = new ArrayCollection();		//选中组件的holder
		private var _mouseDownOffsetPoint:Point;	//鼠标按下时，光标相对于选中组件的位置
		private var _mouseDownPoint:Point;			//鼠标按下时的位置
		private var _shapeCoorLine:Shape;			//用于在拖动时显示鼠标位置的十字线画布
		
		private var _isDraging:Boolean;			//是否正在拖动控件
		
		private var _scale:Number = 1;				//当前缩放值，不对外，使用zoomIn/zoomOut控制
		private var _selectedSizerDic:Dictionary = new Dictionary();	//选中的控件的尺寸调整器
		private var _componentArr:ArrayCollection = new ArrayCollection();	//所有添加的组件
		
		public function CodeCanvas()
		{
			super();
			addListeners();
	
		}
		
		override public function toString():String
		{
			return "设计视图";
		}
		
		/**
		 * 缩放还原 
		 * 
		 */		
		public function zoomReset():void
		{
			_scale = 1;
			groupContent.scaleX = groupContent.scaleY = _scale;
		}
		/**
		 * 放大 
		 * 
		 */		
		public function zoomIn():void
		{
			_scale *= 1.01;
			if(_scale > 3)
				_scale = 3;
			groupContent.scaleX = groupContent.scaleY = _scale;
		}
		
		/**
		 * 缩小 
		 * 
		 */		
		public function zoomOut():void
		{
			_scale *= 0.99;
			if(_scale < 1)
				_scale = 1;
			groupContent.scaleX = groupContent.scaleY = _scale;;
		}
		
		private function addListeners():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		protected function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.DELETE)
				removeComponent(selectedComponent);
			else
			{
				if(_selectedComponentArr)
				{
					var len:Number = 1/_scale;
					for (var i:int = 0; i < _selectedComponentArr.length; i++) 
					{
						var ui:UIComponent = _selectedComponentArr.getItemAt(i) as UIComponent;
						if(ui == _rootComponent)
							continue;
						var uiX:Number = ui.x;
						var uiY:Number = ui.y;
						switch(event.keyCode)
						{
							case Keyboard.LEFT:
								uiX -= len;
								break;
							case Keyboard.RIGHT:
								uiX += len;
								break;
							case Keyboard.UP:
								uiY -= len;
								break;
							case Keyboard.DOWN:
								uiY += len;
								break;
						}
						ui.x = uiX;
						ui.y = uiY;
					}
				}
			}
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			var component:UIComponent = event.target as UIComponent;
			if(component == rootComponent || _componentArr.getItemIndex(component) >= 0)		//如果包含到尺寸调整器中，不处理
			{
				if(component)
				{
					addSelectedComponent(component, event.shiftKey);
					_mouseDownPoint = new Point(selectedHolder.mouseX, selectedHolder.mouseY);
					_mouseDownOffsetPoint = new Point(selectedHolder.component.mouseX, selectedHolder.component.mouseY);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_moveHandler);
					stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				}
				else
				{
					removeAllSelectedUIComponent();
				}
			}
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_moveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_mouseDownOffsetPoint = null;
			_mouseDownPoint = null;
			_isDraging = false;
			hideCoorLine();
		}
		
		protected function stage_moveHandler(event:MouseEvent):void
		{
			if(selectedHolder)
			{
				if(!_isDraging)
				{
					_isDraging = new Point(selectedHolder.mouseX, selectedHolder.mouseY).subtract(_mouseDownPoint).length > 6;
				}
				if(_isDraging)
				{
					var component:UIComponent = selectedHolder.component;
					if(component && component != _rootComponent)
					{
						component.x = Math.round(selectedHolder.mouseX - _mouseDownOffsetPoint.x);
						component.y = Math.round(selectedHolder.mouseY - _mouseDownOffsetPoint.y);
						showCoorLine();
					}
				}
			}
		}
		
		private function showCoorLine():void
		{
			if(_shapeCoorLine == null)
			{
				_shapeCoorLine = new Shape();
			}
			if(!contains(_shapeCoorLine))
				groupContent.addChild(_shapeCoorLine);
			groupContent.setChildIndex(_shapeCoorLine, groupContent.numChildren - 1);
			
			var g:Graphics = _shapeCoorLine.graphics;
			g.clear();
			g.lineStyle(1, 0, 0.3, false, LineScaleMode.NONE);
			if(selectedComponent)
			{
				
				
				g.moveTo(0, selectedComponent.y);
				g.lineTo(groupContent.width, selectedComponent.y);
				
				g.moveTo(0, selectedComponent.y + selectedComponent.height);
				g.lineTo(groupContent.width, selectedComponent.y + selectedComponent.height);
				
				g.moveTo(selectedComponent.x, 0);
				g.lineTo(selectedComponent.x, groupContent.height);
				
				g.moveTo(selectedComponent.x + selectedComponent.width, 0);
				g.lineTo(selectedComponent.x + selectedComponent.width, groupContent.height);
			}
		}
		
		private function hideCoorLine():void
		{
			if(_shapeCoorLine && contains(_shapeCoorLine))
			{
				groupContent.removeChild(_shapeCoorLine);
			}
		}
		
		/**
		 * 选中组件
		 * @param value 要选中组件的外壳
		 * @param multiple 是否多选
		 * 
		 */		
		private function addSelectedComponent(value:UIComponent, multiple:Boolean = false):void
		{
			
			//如果不允许多选，清除所有选中项
			//如果value已选中，移到最顶层
			//如果未选中创建新的Sizer，添加到Sizer集合中
			//给最新选中的项，添加事件
			if(!multiple)
				removeAllSelectedUIComponent();
			if(isSelected(value))
			{
				_selectedComponentArr.moveItem(value, _selectedComponentArr.length - 1);
			}
			else
			{
				var sizer:Sizer = new Sizer();
				sizer.target = value;
				_selectedSizerDic[value] = sizer;
				_selectedComponentArr.addItem(value);
				value.addEventListener(MoveEvent.MOVE, selectedComponent_moveHandler);
				value.addEventListener(ResizeEvent.RESIZE, selectedComponent_resizeHandler);
			}
			updateForSelectedHolder(value);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function isSelected(value:UIComponent):Boolean
		{
			return getSelectedIndex(value) >= 0;
		}
		
		private function getSelectedIndex(value:UIComponent):int
		{
			if(_selectedComponentArr)
			{
				return _selectedComponentArr.getItemIndex(value);
			}
			return -1;
		}
		
		private function removeAllSelectedUIComponent():void
		{
			while(_selectedComponentArr.length > 0)
			{
				removeSelectedUIComponent(_selectedComponentArr.getItemAt(0) as UIComponent);
			}
		}
		
		private function removeSelectedUIComponent(value:UIComponent):void
		{
			value.removeEventListener(MoveEvent.MOVE, selectedComponent_moveHandler);
			value.removeEventListener(ResizeEvent.RESIZE, selectedComponent_resizeHandler);
			var sizer:Sizer = _selectedSizerDic[value];
			if(sizer)
				sizer.target = null;
			_selectedComponentArr.removeItem(value);
			delete _selectedSizerDic[value];
		}
		
		protected function selectedComponent_resizeHandler(event:ResizeEvent):void
		{
			updateForSelectedHolder(event.currentTarget as UIComponent);
		}
		
		protected function selectedComponent_moveHandler(event:MoveEvent):void
		{
			updateForSelectedHolder(event.currentTarget as UIComponent);
		}
		
		private function updateForSelectedHolder(component:UIComponent):void
		{
			if(component)
			{
				var sizer:Sizer = _selectedSizerDic[component];
				sizer.target = component;
				if(component == selectedComponent)
					labelCoor.text = "坐标:" + component.x + "," + component.y + "\r" + 
						"尺寸:" + component.width + "," + component.height;
			}
			else
			{
				labelCoor.text = "";
			}
		}
		
		private function getParentHolder(target:DisplayObject):Holder
		{
			var result:DisplayObject = target;
			while(!(result is Holder))
			{
				if(result.parent == null)
					return null;
				result = result.parent;
			}
			return result as Holder;
		}
		
		private function addDropListener():void
		{
			addEventListener(DragEvent.DRAG_ENTER, rootComponent_dragEnterHandler);
			addEventListener(DragEvent.DRAG_DROP, rootComponent_dragDropHandler);
		}
		
		protected function rootComponent_dragDropHandler(event:DragEvent):void
		{
			var point:Point = event.dragSource.dataForFormat("point") as Point;
			var child:UIComponent = event.dragSource.dataForFormat("control") as UIComponent;
			child.x = _rootComponent.mouseX - point.x;
			child.y = _rootComponent.mouseY - point.y;
			addComponent(child);
		}
		
		private function addComponent(component:UIComponent):void
		{
			component.name = searchName(component);
			component.mouseChildren = false;
			var holder:Holder = new Holder();
			holder.component = component;
			_componentArr.addItem(component);
			_rootComponent.addChild(holder);
		}
		
		private function removeComponent(component:UIComponent):void
		{
			var holder:Holder = getParentHolder(component);
			if(holder && holder.parent)
			{
				holder.component = null;
				holder.parent.removeChild(holder);
			}
			_componentArr.removeItem(component);
			if(isSelected(component))
				removeSelectedUIComponent(component);
		}
		/**
		 * 寻找合适的默认名称。格式为Type + 序号，例如Button1 
		 * @param obj 要寻找默认名称的对象
		 * @return 寻找的默认名称
		 * 
		 */	 	
		private function searchName(obj:UIComponent):String
		{
			var packageType:String = getQualifiedClassName(obj);
			var classType:String = ClassUtil.getClassString(obj);
			classType = classType.substr(0, 1).toLowerCase() + classType.substr(1);
			var index:int = searchIndex(rootComponent, getDefinitionByName(packageType) as Class);
			return classType + index;
		}
		
		/**
		 * 查看根组件一共包含多少指定类型的子对象 
		 * @param type 类型
		 * @return 包含的数量
		 * 
		 */		
		private function searchIndex(container:UIComponent, type:Class):int
		{
			var result:int = 0;
			if(container)
			{
				for(var i:int = 0; i < container.numChildren; i++)
				{
					var child:UIComponent = container.getChildAt(i) as UIComponent;
					if(child)
					{
						if(child is type && child.parent is Holder)
						{
							result++;
						}
						result += searchIndex(child, type);
					}
				}
			}
			return result;
			
		}
		
		protected function rootComponent_dragEnterHandler(event:DragEvent):void
		{
			if(event.dragSource.hasFormat("control"))
			{
				DragManager.acceptDragDrop(this);
			}
		}
		
		private function removeDropListener():void
		{
			removeEventListener(DragEvent.DRAG_ENTER, rootComponent_dragEnterHandler);
			removeEventListener(DragEvent.DRAG_DROP, rootComponent_dragDropHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			scaleplate = new Scaleplate();
			scaleplate.percentWidth = 100;
			scaleplate.percentHeight = 100;
			
			groupContent = new Group();
			groupContent.percentWidth = 100;
			groupContent.percentHeight = 100;
			groupContent.x = scaleplate.empty;
			groupContent.y = scaleplate.empty;
			
			scaleplate.groupContent = groupContent;
			addChild(groupContent);
			addChild(scaleplate);
			
			_rootHolder = new Holder();
			_rootHolder.name = "rootH";
			groupContent.addChild(_rootHolder);
			
			labelCoor = new Label();
			labelCoor.right = 0;
			labelCoor.top = scaleplate.empty;
			addChild(labelCoor);
		}
		
		/**
		 * 根控件 
		 */
		public function get rootComponent():UIComponent
		{
			return _rootComponent;
		}
		
		/**
		 * @private
		 */
		public function set rootComponent(value:UIComponent):void
		{
			if(_rootComponent != value)
			{
				if(_rootComponent)
				{
					removeDropListener();
					_rootHolder.component = null;
				}
				_rootComponent = value;
				_rootComponent.name = "rootC";
				if(_rootComponent)
				{
					_rootHolder.component = _rootComponent;
					addDropListener();
				}
			}
		}
		
		public function get selectedHolder():Holder
		{
			if(selectedComponent)
				return getParentHolder(selectedComponent);
			return null;
		}
		
		public function get selectedComponent():UIComponent
		{
			if(_selectedComponentArr && _selectedComponentArr.length > 0)
				return _selectedComponentArr.getItemAt(_selectedComponentArr.length - 1) as UIComponent;
			return null;
		}
	}
}