package remote2.net
{
	import flash.display.Loader;
	import flash.net.URLLoader;
	
	import mx.utils.StringUtil;
	
	/**
	 * 加载器创建者
	 * @author 徐俊杰
	 * @date 2012-2-22
	 */
	internal class LoadItemCreater
	{
		private static const IMAGE:Array = [".jpg", ".png", ".bmp", ".swf"];
		private static const SOUND:Array = [".mp3"];
		/**
		 * 
		 * @param type ，参考LoaderType
		 * @return 加载器
		 * 
		 */		
		/**
		 * 创建加载器 
		 * @param url 路径
		 * @param maxTries 最大重连次数
		 * @param loaderType 加载器类型 ，需要实现ILoadItem接口
		 * @param key 标识符，如果为空，则使用url做为标识符
		 * @return 加载器
		 * 
		 * @see ILoadItem
		 * 
		 */		
		public static function createItem(url:String, maxTries:int, loaderType:Class, key:String = null):ILoadItem
		{
			if(loaderType == null)
				loaderType = getType(url);
			var result:* = new loaderType();
			if(result is ILoadItem)
			{
				(result as ILoadItem).url = url;
				(result as ILoadItem).maxTries = maxTries;
				if(key != null)
					(result as ILoadItem).key = key;
				return result;
			}
			else
			{
				throw new Error(StringUtil.substitute("{0}不是{1}类型", loaderType, ILoadItem));
				return null;
			}
				
		}
		
		/**
		 * 根据路径获取加载器类型 
		 * @param url 路径
		 * @return 加载器类
		 * 
		 */		
		public static function getType(url:String):Class
		{
			if(url.indexOf("?") >= 0)
				url = url.substring(0, url.indexOf("?"));
			var index:int = url.lastIndexOf(".");
			if(index >= 0)
			{
				var extens:String = url.substring(index);
				if(IMAGE.indexOf(extens) != -1)
					return LoaderItem;
			}
			return URLLoaderItem;
		}
	}
}