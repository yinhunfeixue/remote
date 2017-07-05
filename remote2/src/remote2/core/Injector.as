package remote2.core
{
	import flash.utils.Dictionary;
	
	/**
	 * 全局注入器
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-3
	 */	
	public class Injector
	{
		private static var _data:Dictionary = new Dictionary();
		
		/**
		 * 注入类，同一个标识的类，只在第一次注入时有效
		 * @param key 标识
		 * @param type 类
		 * 
		 */		
		public static function mapClass(key:*, type:Class):void
		{
			if(_data[key] == null)
				_data[key] = type;
		}
		
		/**
		 * 是否已注入 
		 * @param key 标识
		 * @return 是否为对应标识注入类
		 * 
		 */		
		remote_internal static function hasClass(key:*):Boolean
		{
			return _data[key] != null;
		}
		
		/**
		 * 删除类型 
		 * @param key
		 * 
		 * @private
		 */		
		remote_internal static function deleteClass(key:*):void
		{
			if(_data[key])
				delete _data[key];
		}
		
		/**
		 * 创建实例 
		 * @param key 标识
		 * @return 对应类的实例 
		 * 
		 */		
		public static function createInstance(key:*):*
		{
			if(_data[key] == null)
				return null;
			if(_data[key] is Class)
				return new _data[key]();
			return _data[key];
		}
		
		/**
		 * 获取标识的实例，此方法获取唯一实例
		 * @param key 标识
		 * @return 对应类的实例 
		 * 
		 */		
		public static function getInstance(key:*):*
		{
			if(_data[key] == null)
				return null;
			if(_data[key] is Class)
				_data[key] = new _data[key]();
			return _data[key];
		}
	}
}