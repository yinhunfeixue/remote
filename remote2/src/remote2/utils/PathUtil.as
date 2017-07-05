package remote2.utils
{
	/**
	 * 路径处理类 
	 * @author 徐俊杰
	 * 
	 */	
	public class PathUtil
	{
		public static const REPLACE_REG:RegExp = /[\\]+|[\/]+/g;//new RegExp("[\/\\]+", "g");
		/**
		 * 获取不包含文件名的路径
		 * @param path 完整路径
		 * @return 不包含文件名的路径
		 * 
		 * @example file://a/b/c/1.txt --> file://a/b/c/
		 */		
		public static function getPath(path:String):String
		{
			path = path.replace(REPLACE_REG, "/");
			var index:int = path.lastIndexOf("/");
			if(index >= 0)
				return path.substring(0, index + 1);
			return "";
		}
		
		/**
		 * 获取文件名称 
		 * @param path 完整路径
		 * @return 文件名称
		 * 
		 * @example file://a/b/c/1.txt --> 1.txt
		 */		
		public static function getFileName(path:String):String
		{
			path = path.replace(REPLACE_REG, "/");
			var index:int = path.lastIndexOf("/");
			index += 1;
			if(index < 0)
				index = 0;
			return path.substring(index, path.length);
		}
		
		/**
		 * 获取扩展名，包含.
		 * @param path 完整路径
		 * @return 扩展名
		 * 
		 * @example .txt  .docs
		 */		
		public static function getExtension(path:String):String
		{
			var index:int = path.lastIndexOf("?");
			if(index >= 0)
				path = path.substring(0, index);
			var lastPoint:int = path.lastIndexOf(".");
			if(lastPoint >= 0)
				return path.substring(lastPoint);
			return "";
		}
		
		/**
		 * 获取不带扩展名的文件名 
		 * @param path 完整路径
		 * @return 不带扩展名的文件名
		 * 
		 * @example file://a/b/c/1.txt --> 1
		 * 
		 */		
		public static function getFileNameWithoutExtension(path:String):String
		{
			path = path.replace(REPLACE_REG, "/");
			var index:int =  path.lastIndexOf("/");
			index += 1;
			if(index < 0)
				index = 0;
			var lastPoint:int = path.lastIndexOf(".");
			if(lastPoint < 0)
				lastPoint = path.length;
			return path.substring(index, lastPoint);
		}
		
		/**
		 * 获取上一级目录的路径 
		 * @param path 完整路径
		 * @return 上一级目录的路径
		 * 
		 * @example file://a/b/c/ --> file://a/b/
		 * 
		 */		
		public static function getParentPath(path:String):String
		{
			path = path.replace(REPLACE_REG, "/");
			var index:int = path.lastIndexOf("/");
			if(index == path.length)
				index = path.lastIndexOf("/", index);
			return path.substring(0, index);
		}
	}
}