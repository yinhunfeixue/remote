package modules.select
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import remote2.components.Image;
	import remote2.components.Label;
	import remote2.components.UIComponent;
	import remote2.components.supports.ItemRenderBase;
	import remote2.core.ClassFactory;
	import remote2.core.DragControl;
	import remote2.core.DragSource;
	import remote2.core.remote_internal;
	import remote2.events.DragEvent;
	import remote2.layouts.HorizontalLayout;
	import remote2.layouts.VerticalAlign;
	import remote2.manager.DragManager;
	import remote2.utils.ClassUtil;
	
	use namespace remote_internal;
	
	/**
	 * 选择器模板
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class SelectorItemRender extends ItemRenderBase
	{
		
		protected var labelDisplay:Label;
		protected var imageIcon:Image;
		
		private var _dataChanged:Boolean;
		
		private var _dragControl:DragControl;
		
		private var _bitmapDataForDrag:BitmapData;
		
		
		public function SelectorItemRender()
		{
			super();
			height = 30;
			
			var l:HorizontalLayout = new HorizontalLayout();
			l.gap = 5;
			l.paddingLeft = 20;
			l.verticalAlign = VerticalAlign.MIDDLE;
			layout = l;
			
			_dragControl = new DragControl(this);
			addEventListener(DragEvent.DRAG_START, dragStartHandler);
		}
		
		protected function dragStartHandler(event:DragEvent):void
		{
			var defaultUi:UIComponent = createDefaultUi();
			var source:DragSource = new DragSource();
			source.addData(defaultUi, "control");
			source.addData(new Point(0,0), "point");
			DragManager.doDrag(this, source, event, createDragImage(defaultUi));
		}
		
		private function createDragImage(ui:UIComponent):DisplayObject
		{
			var sprite:Sprite = new Sprite();
			sprite.mouseEnabled = false;
			sprite.mouseChildren = false;
			sprite.addChild(ui);
			
			var g:Graphics = sprite.graphics;
			g.clear();
			g.lineStyle(1);
			g.moveTo(0, -stage.height);
			g.lineTo(0, stage.height);
			g.moveTo(-stage.width, 0);
			g.lineTo(stage.width, 0);
			
			g.drawRect(0, 0, ui.width, ui.height);
			
			
			return sprite;
		}
		
		private function createDefaultUi():UIComponent
		{
			if(selectorData)
			{
				var ui:UIComponent = new ClassFactory(selectorData.type, selectorData.defaultProperties).newInstance();
				if(selectorData.defaultSize)
				{
					ui.width = selectorData.defaultSize.width;
					ui.height = selectorData.defaultSize.height;
				}
				return ui;
			}
			return null;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataChanged)
			{
				_dataChanged = false;
				if(selectorData)
				{
					var packageType:String = ClassUtil.getPackageString(selectorData.type);
					var classType:String = ClassUtil.getClassString(selectorData.type);
					labelDisplay.text = classType;
					toolTip = packageType;
					imageIcon.source = selectorData.icon;
					_dragControl.allowDrag();
				}
				else
				{
					_dragControl.refuseDrag();
				}
			}
		}
		
		override public function set data(value:*):void
		{
			super.data = value;
			_dataChanged = true;
			invalidateProperties();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			imageIcon = new Image();
			imageIcon.width = imageIcon.height = 20;
			addChild(imageIcon);
			
			labelDisplay = new Label();
			addChild(labelDisplay);
		}
		
		public function get selectorData():SelectorData
		{
			return data;
		}
	}
}