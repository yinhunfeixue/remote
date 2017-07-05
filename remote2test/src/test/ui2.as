package test
{
	import flash.events.MouseEvent;
	
	import remote2.components.Group;
	import remote2.components.SkinnableComponent;
	import remote2.components.UIComponent;
	
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-15
	 */	
	public class ui2 extends UIComponent
	{
		private var _add:Boolean;
		public function ui2()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);
		}
		
		protected function stage_clickHandler(event:MouseEvent):void
		{
			_add = true;
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			if(_add)
			{
				_add = false;
				var btn:UIComponent = new UIComponent();
				btn.name = "bbb";
				btn.autoDrawRepsonse = true;
				btn.x = 100;
				btn.y = 100;
				stage.addChild(btn);
			}
		}
	}
}