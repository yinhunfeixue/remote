package remote2.skins
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * 主题基类，用于关联样式和皮肤类 
	 * @author yinhunfeixue
	 * 
	 */	
	public class Theme extends EventDispatcher
	{
		private var _skinDic:Dictionary;
		
		public function Theme()
		{
			_skinDic = new Dictionary();
		}
		
		/**
		 * 添加样式 
		 * @param styleName 样式名，可以是类，或者类的完全限定名，也可以任一字符串。<p><b>如果是类或者完全限定名，则会被设置为此类的默认样式</b></p>
		 * @param skinClass 皮肤类
		 * 
		 */		
		public function mapSkin(styleName:*, skinClass:Class):void
		{
			if(styleName is Class)
				styleName = getQualifiedClassName(styleName);
			_skinDic[styleName] = skinClass;
		}
		
		/**
		 * 获取皮肤类 
		 * @param styleName 样式名
		 * @return 皮肤类
		 * 
		 */		
		public function getSkinClass(styleName:*):Class
		{
			if(_skinDic[styleName])
				return _skinDic[styleName];
			return null;
		}
		
		/**
		 * 移除样式类 
		 * @param styleName 样式名
		 * 
		 */		
		public function removeClass(styleName:String):void
		{
			if(_skinDic && _skinDic[styleName])
				delete _skinDic[styleName];
		}
	}
}