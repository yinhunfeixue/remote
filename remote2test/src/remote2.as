package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import remote2.components.Button;
	import remote2.components.Group;
	import remote2.components.Label;
	import remote2.components.RichEditableText;
	import remote2.components.SystemManager;
	import remote2.components.TextArea;
	
	public class remote2 extends SystemManager
	{
		public function remote2()
		{	
			super();
			
			var g:Group = new Group();
			g.width = 200;
			addChild(g);
			
			var g2:Group = new Group();
			g2.left = 10;
			g2.right = 10;
			g2.percentWidth = 100;
			g.addChild(g2);
			
			var b:Button = new Button();
			b.label = "aaa";
			b.left = 0;
			b.right = 0;
			g2.addChild(b);
			
			
		
		}
		
		//		override protected function preinitialize():void
		//		{
		//			super.preinitialize();
		//			StyleManager.mapTheme(TestTheme);
		//			
		//			stage.frameRate = 60;
		//			percentWidth = 100;
		//			percentHeight = 100;
		//		}
		//
		//		
		//		override protected function createChildren():void
		//		{
		//			super.createChildren();
		//			
		//			var t:TextField = new TextField();
		//			t.defaultTextFormat = new TextFormat("宋体");
		//			t.text = "名称";
		//			addChild(t);
		//			return;
		//			var button:Button = new Button();
		//			button.label = "aaaaaa";
		//			button.mouseChildren = false;
		//			addChild(button);
		//			button.addEventListener(MouseEvent.CLICK, button_clickHandler);
		//			return;
		//			Model.personModel.read();
		//			Model.personModel.addEventListener(Event.CHANGE, personModel_changeHandler);
		//			
		//			personList = new List();
		//			personList.percentHeight = 100;
		//			personList.itemRender = PersonItemRender;
		//			personList.right = 10;
		//			addChild(personList);
		//			
		//			personList.dataProvider = new ArrayCollection(Model.personModel.personArr);
		//			
		//			createControl();
		//
		//		}
		//		
		//		protected function button_clickHandler(event:MouseEvent):void
		//		{
		//			trace("click");
		//		}
		//		
		//		protected function personModel_changeHandler(event:Event):void
		//		{
		//			personList.update();
		//		}
		//		
		//		private function createControl():void
		//		{
		//			var group:Group = new Group();
		//			addChild(group);
		//			
		//			var btnAdd:Button = new Button();
		//			btnAdd.label = "添加联系人";
		//			btnAdd.addEventListener(MouseEvent.CLICK, btnAdd_clickHandler);
		//			group.addChild(btnAdd);
		//		}
		//		
		//		protected function btnAdd_clickHandler(event:MouseEvent):void
		//		{
		//			PopUpManager.createPopUp(EditWindow);
		//		}
	}
}