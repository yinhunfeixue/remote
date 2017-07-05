package viewStackTest
{
	import flash.events.MouseEvent;
	
	import remote2.components.Button;
	import remote2.components.ButtonBar;
	import remote2.components.Group;
	import remote2.components.NavigatorContent;
	import remote2.components.Sizer;
	import remote2.components.SystemManager;
	import remote2.components.UIComponent;
	import remote2.components.ViewStack;
	
	/**
	 * 
	 *
	 * @author xujunjie
	 * @date 2013-5-19 下午5:27:40
	 * 
	 */	
	public class testComponent extends SystemManager
	{
		
		private var viewStack:ViewStack;
		
		private var sizer:Sizer;
		public function testComponent()
		{
			super();
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			
			stage.frameRate = 60;
			percentWidth = 100;
			percentHeight = 100;
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			viewStack = new ViewStack();
			addChild(viewStack);
			
			var con:NavigatorContent = new NavigatorContent();
			con.label = "tab1";
			
//			for(var i:int = 0; i < 10; i++)
//			{
//				for(var j:int = 0; j < 10; j++)
//				{
//					var btn:Button = new Button();
//					btn.width = 30;
//					btn.height = 20;
//					btn.label = "aaa";
//					btn.addEventListener(MouseEvent.CLICK, btn_clickHandler);
//					btn.move(j * 32, i * 22);
//					con.addChild(btn);
//				}
//			}
			
			var con2:Group = new Group();
			
			viewStack.addItem(con);
			viewStack.addItem(con2);
			
			var bar:ButtonBar = new ButtonBar();
			bar.dataProvider = viewStack;
			addChild(bar);
		}
		
		protected function btn_clickHandler(event:MouseEvent):void
		{
			//viewStack.removeItemAt(1);
			if(sizer == null)
				sizer = new Sizer();
			sizer.target = (event.target as Button);
		}
	}
}