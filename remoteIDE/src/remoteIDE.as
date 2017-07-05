package
{
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	
	import code.IEncode;
	import code.TemplateEncode;
	import code.actionscript.ObjectEncode;
	import code.actionscriptXML.ObjectEncode;
	
	import configs.ConfigWindow;
	import configs.init.Init;
	
	import modules.canvas.CodeCanvas;
	import modules.project.view.CreateWindow;
	import modules.project.vo.ProjectData;
	import modules.select.SelectorList;
	import modules.setter.SetterPanel;
	import modules.zoom.ZoomBar;
	import modules.zoom.events.ZoomEvent;
	
	import remote2.components.Button;
	import remote2.components.ButtonBar;
	import remote2.components.Group;
	import remote2.components.NavigatorContent;
	import remote2.components.SkinnableComponent;
	import remote2.components.SystemManager;
	import remote2.components.TextArea;
	import remote2.components.ViewStack;
	import remote2.events.CloseEvent;
	import remote2.layouts.HorizontalLayout;
	import remote2.layouts.VerticalLayout;
	import remote2.manager.PopUpManager;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class remoteIDE extends SystemManager
	{
		protected var canvas:CodeCanvas;		//画布

		protected var setter:SetterPanel;				//属性设置

		protected var codeViewStack:ViewStack;		//画布和代码选项卡

		protected var groupHead:Group;				//头部区域
		protected var groupContent:Group;			//内容区域

		protected var codeTextArea:TextArea;		//代码文本框
		protected var xmlTextArea:TextArea;		//XML代码文本框
		
		private var _project:ProjectData;			//项目信息
		protected var zoomBar:ZoomBar;
		
		public function remoteIDE()
		{
			super();
			stage.frameRate = 60;
			percentWidth = 100;
			percentHeight = 100;
			
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, invokeHandler);
		}
		
		protected function invokeHandler(event:InvokeEvent):void
		{
			//处理打开的项目文件
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			

			createHead();
			
			groupContent = new Group();
			groupContent.top = 100;
			groupContent.bottom = 5;
			groupContent.left = 5;
			groupContent.right = 5;
			addChild(groupContent);
			
			var contentLayout:HorizontalLayout = new HorizontalLayout();
			contentLayout.gap = 5;
			groupContent.layout = contentLayout;
			
			var list:SelectorList = new SelectorList();
			list.width = 200;
			list.percentHeight = 100;
			groupContent.addChild(list);

			createCanvas();
			
			//设置
			setter = new SetterPanel();
			setter.width = 200;
			setter.percentHeight = 100;
			groupContent.addChild(setter);
			
			
			//temp
			var testRoot:SkinnableComponent = new SkinnableComponent();
			testRoot.width = 300;
			testRoot.height = 300;
			canvas.rootComponent = testRoot;
			
			checkInit();

		}
		
		private function alertHandler(event:CloseEvent):void
		{
			trace(event.detail);
		}
		
		private function createHead():void
		{
			groupHead = new Group();
			groupHead.top = 5;
			groupHead.left = 5;
			groupHead.right = 5;
			groupHead.height = 90;
			groupHead.layout = new HorizontalLayout();
			addChild(groupHead);
			
			//创建项目
			var buttonCreate:Button = new Button();
			buttonCreate.label = "创建项目";
			buttonCreate.addEventListener(MouseEvent.CLICK, buttonSave_clickHandler);
			groupHead.addChild(buttonCreate);
		}
		
		protected function buttonSave_clickHandler(event:MouseEvent):void
		{
			var window:CreateWindow = new CreateWindow();
			PopUpManager.addPopUp(window, true);
			PopUpManager.centerPopUp(window);
		}
		
		private function createCanvas():void
		{
			var groupCanvas:Group = new Group();
			var l:VerticalLayout = new VerticalLayout();
			groupCanvas.layout = l;
			groupCanvas.percentWidth = 100;
			groupCanvas.percentHeight = 100;
			groupContent.addChild(groupCanvas);
			
			var groupControl:Group = new Group();
			groupControl.percentWidth = 100;
			groupControl.layout = new HorizontalLayout();
			groupCanvas.addChild(groupControl);
			
			var bar:ButtonBar = new ButtonBar();
			groupControl.addChild(bar);
			
			var space:Group = new Group();
			space.percentWidth = 100;
			groupControl.addChild(space);
			
			zoomBar = new ZoomBar();
			zoomBar.addEventListener(ZoomEvent.ZOOM_IN, zoomBar_zoomInHandler);
			zoomBar.addEventListener(ZoomEvent.ZOOM_OUT, zoomBar_zoomOutHandler);
			zoomBar.addEventListener(ZoomEvent.RESET, zoomBar_resetHandler);
			groupControl.addChild(zoomBar);
			
			codeViewStack = new ViewStack();
			codeViewStack.percentWidth = 100;
			codeViewStack.percentHeight = 100;
			codeViewStack.addEventListener(Event.CHANGE, codeViewStack_changeHandler);
			groupCanvas.addChild(codeViewStack);
			bar.dataProvider = codeViewStack;
			
			canvas = new CodeCanvas();
			canvas.percentWidth = 100;
			canvas.percentHeight = 100;
			canvas.addEventListener(Event.CHANGE, canvas_changeHandler);
			codeViewStack.addItem(canvas);
			
			//xml代码选项卡
			var nv1:NavigatorContent = new NavigatorContent();
			nv1.label = "XML代码";
			nv1.percentWidth = 100;
			nv1.percentHeight = 100;
			codeViewStack.addItem(nv1);
			
			xmlTextArea = new TextArea();
			xmlTextArea.percentWidth = 100;
			xmlTextArea.percentHeight = 100;
			nv1.addChild(xmlTextArea);
			
			//代码选项卡
			var nv2:NavigatorContent = new NavigatorContent();
			nv2.label = "代码";
			nv2.percentWidth = 100;
			nv2.percentHeight = 100;
			codeViewStack.addItem(nv2);
			
			codeTextArea = new TextArea();
			codeTextArea.percentWidth = 100;
			codeTextArea.percentHeight = 100;
			nv2.addChild(codeTextArea);

		}
		
		protected function zoomBar_resetHandler(event:Event):void
		{
			canvas.zoomReset();
		}
		
		protected function zoomBar_zoomInHandler(event:ZoomEvent):void
		{
			canvas.zoomIn();
		}
		
		protected function zoomBar_zoomOutHandler(event:ZoomEvent):void
		{
			canvas.zoomOut();
		}
		
		protected function codeViewStack_changeHandler(event:Event):void
		{
			if(codeViewStack.selectedIndex == 1)
			{
				var xmlEncode:IEncode = new code.actionscriptXML.ObjectEncode(new TemplateEncode("actionscript3XML"), "TempClass");
				var str:String = xmlEncode.encode(canvas.rootComponent);
				xmlTextArea.text = str;
			}
			else if(codeViewStack.selectedIndex == 2)
			{
				var codeEncode:IEncode = new code.actionscript.ObjectEncode(new TemplateEncode("actionscript3"), "TempClass");
				codeTextArea.text = codeEncode.encode(canvas.rootComponent);
			}
		}
		
		private function checkInit():void
		{
			if(!Init.isInited)
			{
				var configWindow:ConfigWindow = new ConfigWindow();
				PopUpManager.addPopUp(configWindow, true);
				PopUpManager.centerPopUp(configWindow);
			}
			else
			{
				Init.read();
			}
		}
		
		protected function canvas_changeHandler(event:Event):void
		{
			setter.component = canvas.selectedComponent;
			if(canvas.selectedComponent == canvas.rootComponent)
				setter.enabled = false;
			else
				setter.enabled = true;
		}
		
		protected function buttonCode_clickHandler(event:MouseEvent):void
		{
			
		}
	}
}




