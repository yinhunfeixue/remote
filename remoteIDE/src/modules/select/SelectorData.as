package modules.select
{
	import remote2.geom.Size;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class SelectorData
	{
		/**
		 * 图标 
		 */		
		public var icon:*;
		
		/**
		 * 组件类型 
		 */		
		public var type:Class;
		
		/**
		 * 默认尺寸
		 */		
		public var defaultSize:Size;
		
		/**
		 * 默认属性 
		 */		
		public var defaultProperties:Object = null;
		
		
		public function SelectorData(icon:*, type:Class, defaultSize:Size = null, defaultProperties:Object = null)
		{
			this.icon = icon;
			this.type = type;
			this.defaultSize = defaultSize;
			this.defaultProperties = defaultProperties;
		}
	}
}