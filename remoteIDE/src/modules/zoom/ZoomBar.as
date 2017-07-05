package modules.zoom
{
	import flash.events.MouseEvent;
	
	import remote2.components.Button;
	import remote2.components.Group;
	import remote2.events.RemoteEvent;
	import remote2.layouts.HorizontalLayout;
	
	import modules.zoom.events.ZoomEvent;
	
	[Event(name="zoomIn", type="modules.zoom.events.ZoomEvent")]
	[Event(name="zoomOut", type="modules.zoom.events.ZoomEvent")]
	
	/**
	 * 
	 * 缩放控制条
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-20
	 *
	 * */
	public class ZoomBar extends Group
	{
		public var buttonZoomIn:Button;
		public var buttonZoomOut:Button;
		public var buttonReset:Button;
		
		public function ZoomBar()
		{
			super();
			layout = new HorizontalLayout();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			buttonZoomIn = new Button();
			buttonZoomIn.label = "+";
			buttonZoomIn.autoRepeat = true;
			buttonZoomIn.addEventListener(RemoteEvent.BUTTON_DOWN, buttonZoomIn_buttonDownHandler);
			addChild(buttonZoomIn);
			
			buttonZoomOut = new Button();
			buttonZoomOut.label = "-";
			buttonZoomOut.autoRepeat = true;
			buttonZoomOut.addEventListener(RemoteEvent.BUTTON_DOWN, buttonZoomOut_buttonDownHandler);
			addChild(buttonZoomOut);
			
			buttonReset = new Button();
			buttonReset.label = "o";
			buttonReset.addEventListener(MouseEvent.CLICK, buttonReset_clickHandler);
			addChild(buttonReset);
		}
		
		protected function buttonReset_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZoomEvent(ZoomEvent.RESET));
		}
		
		protected function buttonZoomOut_buttonDownHandler(event:RemoteEvent):void
		{
			dispatchEvent(new ZoomEvent(ZoomEvent.ZOOM_OUT));
		}
		
		protected function buttonZoomIn_buttonDownHandler(event:RemoteEvent):void
		{
			
			dispatchEvent(new ZoomEvent(ZoomEvent.ZOOM_IN));
		}
	}
}