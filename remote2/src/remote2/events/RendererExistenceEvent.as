package remote2.events
{
	import flash.events.Event;
	
	import remote2.core.IItemRender;
	
	/**
	 * 数据源子项事件 
	 * @author yinhunfeixue
	 * 
	 */	
	public class RendererExistenceEvent extends Event
	{
		/**
		 * 子项添加事件 
		 */		
		public static const RENDERER_ADD:String = "rendererAdd";
		
		/**
		 * 子项移除事件 
		 */		
		public static const RENDERER_REMOVE:String = "rendererRemove";
		
		
		
		/**
		 * 子项数据
		 */		
		public var data:Object;
		
		/**
		 * 子项序号 
		 */		
		public var index:int;
		
		/**
		 * 子项
		 */		
		public var renderer:IItemRender;
		
		/**
		 * 实例化 
		 * @param type 类型
		 * @param bubbles
		 * @param cancelable
		 * @param renderer 子项
		 * @param index 子项序号
		 * @param data 子项数据
		 * 
		 */		
		public function RendererExistenceEvent(
			type:String, bubbles:Boolean = false,
			cancelable:Boolean = false,
			renderer:IItemRender = null, 
			index:int = -1, data:Object = null)
		{
			super(type, bubbles, cancelable);
			
			this.renderer = renderer;
			this.index = index;
			this.data = data;
		}

		/**
		 *  @inheritDoc
		 */		
		override public function clone():Event
		{
			return new RendererExistenceEvent(type, bubbles, cancelable,
				renderer, index, data);
		}
	}
	
}
