package remote2.manager
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import remote2.components.SkinnableComponent;
	import remote2.skins.Theme;

	/**
	 * 样式管理器，可设置主题 
	 * @author yinhunfeixue
	 * 
	 */	
	public class StyleManager
	{
		private static var _instance:StyleManager;
		
		public static function get instance():StyleManager
		{
			if(_instance == null)
				_instance = new StyleManager();
			return _instance;
		}
		
		private var _theme:Theme;
		
		public function StyleManager()
		{
		}
		
		/**
		 * 获取皮肤类，如果当前对象的类型未注册皮肤类，会向父类寻找，直到寻找到皮肤类，或者没有父类为止 
		 * @param obj 拥有皮肤特性的组件
		 * @return 皮肤类
		 * 
		 */		
		public function getClass(obj:SkinnableComponent):Class
		{
			if(_theme == null)
				return null;
			var result:Class = null;
			if(obj.styleName)
				result = _theme.getSkinClass(obj.styleName);
			
			if(result == null)
			{
				var key:* = getQualifiedClassName(obj);
				while(key != null)
				{
					result = _theme.getSkinClass(key);
					if(result != null)
						return result;
					else
						key = getQualifiedSuperclassName(getDefinitionByName(key));
				}
			}
			return result;
		}
		
		/**
		 * 设置主题  
		 * @param themeClass 主题类，建议使用Theme的子类
		 * 
		 * @see remote2.skins.Theme
		 * 
		 */		
		public static function mapTheme(themeClass:Class):void
		{
			if(themeClass == null)
				instance._theme = null;
			else
				instance._theme = new themeClass();
		}

		public function get theme():Theme
		{
			return _theme;
		}
		
		
	}
}