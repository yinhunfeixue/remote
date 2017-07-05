package remote2.skins.remoteSkins
{
	import remote2.components.HScrollBar;
	import remote2.components.Scroller;
	import remote2.components.UIComponent;
	import remote2.components.VScrollBar;
	import remote2.core.IViewport;
	import remote2.core.remote_internal;
	
	use namespace remote_internal;
	
	public class ScrollerSkin extends RemoteSkin
	{
		public var horizontalScollBar:HScrollBar;
		public var verticalScollBar:VScrollBar;
		
		/**
		 * 水平滚动条的宽度或者竖直滚动条的高度 
		 */		
		protected var scrollBarWeight:Number = 15;
		
		public function ScrollerSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			horizontalScollBar = new HScrollBar();
			horizontalScollBar.bottom = 0;
			horizontalScollBar.left = 0;
			horizontalScollBar.right = scrollBarWeight;
			horizontalScollBar.height = scrollBarWeight;

			target.addChild(horizontalScollBar);
			
			verticalScollBar = new VScrollBar();
			verticalScollBar.right = 0;
			verticalScollBar.top = 0;
			verticalScollBar.bottom = scrollBarWeight;
			verticalScollBar.width = scrollBarWeight;
			target.addChild(verticalScollBar);
		}
		
		override public function uninstall():void
		{
			target.removeChild(horizontalScollBar);
			target.removeChild(verticalScollBar);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			updateContainer(target.currentState);
		}
		
		private function updateContainer(state:String):void
		{
			if(viewport == null)
				return;
			switch(state)
			{
				case "bothShow":
					viewport.left = 0;
					viewport.top = 0;
					viewport.right = scrollBarWeight;
					viewport.bottom = scrollBarWeight;
					break;
				case "horizontalShow":
					viewport.left = 0;
					viewport.top = 0;
					viewport.right = 0;
					viewport.bottom = scrollBarWeight;
					break;
				case "verticalShow":
					viewport.left = 0;
					viewport.top = 0;
					viewport.right = scrollBarWeight;
					viewport.bottom = 0;
					break;
				default:
					viewport.left = 0;
					viewport.top = 0;
					viewport.right = 0;
					viewport.bottom = 0;
					break;
			}
			var ui:UIComponent = viewport as UIComponent;
			if(ui)
			{
				//ui.invalidateSize();
			}
			
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "bothShow":
					verticalScollBar.visible = true;
					verticalScollBar.includeInLayout = true;
					verticalScollBar.bottom = scrollBarWeight;
					
					horizontalScollBar.visible = true;
					horizontalScollBar.includeInLayout = true;
					horizontalScollBar.right = scrollBarWeight;
					break;
				case "horizontalShow":
					verticalScollBar.visible = false;
					verticalScollBar.includeInLayout = false;
					
					
					horizontalScollBar.visible = true;
					horizontalScollBar.includeInLayout = true;
					horizontalScollBar.right = 0;
					break;
				case "verticalShow":
					verticalScollBar.visible = true;
					verticalScollBar.includeInLayout = true;
					verticalScollBar.bottom = 0;
					
					horizontalScollBar.visible = false;
					horizontalScollBar.includeInLayout = false;
					break;
				case "bothHide":
					verticalScollBar.visible = false;
					verticalScollBar.includeInLayout = false;
					
					horizontalScollBar.visible = false;
					horizontalScollBar.includeInLayout = false;
					break;
				default:
					verticalScollBar.visible = false;
					verticalScollBar.includeInLayout = false;
					
					horizontalScollBar.visible = false;
					horizontalScollBar.includeInLayout = false;
					break;
			}
			updateContainer(newState);
		}
		
		private function get viewport():IViewport
		{
			return (target as Scroller).viewport;
		}
		
	}
}