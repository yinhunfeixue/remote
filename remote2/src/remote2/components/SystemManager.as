package remote2.components
{
	import flash.display.Graphics;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	
	import remote2.core.Injector;
	import remote2.core.RemoteGlobals;
	import remote2.core.remote_internal;
	import remote2.manager.StyleManager;
	import remote2.manager.ToolTipManager;
	import remote2.manager.dragClasses.DragManagerImpl;
	import remote2.skins.remoteSkins.RemoteTheme;
	
	use namespace remote_internal;
	
	/**
	 * 系统管理器 
	 * @author yinhunfeixue
	 * 
	 */	
	public class SystemManager extends Group
	{
		public function SystemManager()
		{
			super();
		}
		
		/**
		 * 预初始化
		 * 用于全局注入管理，设置皮肤等 
		 * 在此方法中如果不设置自定义管理器、皮肤等；则使用系统默认值
		 * 
		 */		
		protected function preinitialize():void
		{
			
		}
		
		/**
		 * 框架默认的初始化 
		 * 
		 */		
		private function defaultPreinitialize():void
		{
			if(StyleManager.instance.theme == null)
				StyleManager.mapTheme(RemoteTheme);
			if(!Injector.hasClass(RemoteGlobals.KEY_TOOLTIP_MANAGER))
				Injector.mapClass(RemoteGlobals.KEY_TOOLTIP_MANAGER, ToolTipManager);
			if(!Injector.hasClass(RemoteGlobals.KEY_TOOLTIP))
				Injector.mapClass(RemoteGlobals.KEY_TOOLTIP, ToolTip);
			if(!Injector.hasClass(RemoteGlobals.KEY_DRAG_MANAGER))
				Injector.mapClass(RemoteGlobals.KEY_DRAG_MANAGER, DragManagerImpl);
			RemoteGlobals.toolTipLayer = this;
			RemoteGlobals.topApplication = this;
			RemoteGlobals.popupLayer = this;
			//contextMenu = new ContextMenu();
			//contextMenu.hideBuiltInItems();
		}
		
		override protected function initialize():void
		{
			preinitialize();
			RemoteGlobals.init(stage);
			defaultPreinitialize();
			super.initialize();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}
		
		override protected function measure():void
		{
			if(!isNaN(percentWidth) || !isNaN(percentHeight))
			{
				if(!isNaN(percentWidth))
					measuredWidth = Math.floor(stage.stageWidth * percentWidth / 100);
				if(!isNaN(percentHeight))
					measuredHeight = Math.floor(stage.stageHeight * percentHeight / 100);
			}
			else
				super.measure();
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
		}
		
		protected function stage_resizeHandler(event:Event):void
		{
			invalidateSize();
		}
	}
}