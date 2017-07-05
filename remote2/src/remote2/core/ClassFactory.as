package remote2.core
{
	/**
	 * 类工厂
	 * 用于创建指定类的实例，同时赋于指定的属性 
	 * @author xujunjie
	 * 
	 */	
	public class ClassFactory
	{
		/**
		 * 类型 
		 */		
		public var generator:Class;
		
		/**
		 * 初始属性 
		 */		
		public var properties:Object = null;
		
		/**
		 * 实例化 
		 * @param generator 类型
		 * @param defaultProperties 默认属性
		 * 
		 */		
		public function ClassFactory(generator:Class = null, defaultProperties:Object = null)
		{
			super();
			this.generator = generator;
			this.properties = defaultProperties;
		}
		
		/**
		 * 创建新对象 
		 * @return 创建的对象
		 * 
		 */		
		public function newInstance():*
		{
			var instance:Object = new generator();
			
			if (properties != null)
			{
				for (var p:String in properties)
				{
					if(instance.hasOwnProperty(p))
						instance[p] = properties[p];
				}
			}
			
			return instance;
		}
	}
	
}
