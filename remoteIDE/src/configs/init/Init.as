package configs.init
{
	import flash.filesystem.File;
	
	import remote2.utils.FileUtil;
	
	/**
	 * 应用配置初始化
	 * 配置使用XML保存
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-6
	 *
	 * */
	public class Init
	{
		public static var userName:String;
		
		
		/**
		 * 读取 
		 * 
		 */		
		public static function read():void
		{
			var content:XML = new XML(FileUtil.readString(initFile));
			if(content)
			{
				userName = content.userName;
			}
		}
		
		/**
		 * 保存 
		 * 
		 */		
		public static function save():void
		{
			var content:String = "<root>";
			content += "<userName>" + userName + "</userName>";
			content += "</root>";
			FileUtil.writeString(initFile, new XML(content));
		}
		
		/**
		 * 是否已初始化过 
		 * 
		 */		
		public static function get isInited():Boolean
		{
			return initFile.exists;
		}
		
		private static function get initFile():File
		{
			return new File(File.applicationDirectory.nativePath + "/init.xml");
		}
	}
}