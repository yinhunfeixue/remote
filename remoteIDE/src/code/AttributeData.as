package code
{
	
	/**
	 * 一个属性包含的信息
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class AttributeData
	{
		/**
		 * 名称 
		 */		
		public var name:String;
		
		/**
		 * 类型 
		 */		
		public var type:Class;
		
		/**
		 * 默认值，如果当前值是默认值中的一项，表示不需要解析 
		 */		
		public var defaultValues:Array;
		
		/**
		 * 实例化 
		 * @param name 名称
		 * @param type 名称
		 * @param defaultValues 默认值列表，如果当前值是默认值中的一项，表示不需要解析，允许为null
		 * 
		 */		
		public function AttributeData(name:String, type:Class, defaultValues:Array)
		{
			this.name = name;
			this.type = type;
			this.defaultValues = defaultValues;
		}
	}
}