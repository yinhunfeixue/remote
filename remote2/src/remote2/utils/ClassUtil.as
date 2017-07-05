package remote2.utils
{
	import flash.utils.getQualifiedClassName;

	/**
	 * 类型辅助类
	 *
	 * @author xujunjie
	 * @date 2013-6-15 下午8:21:57
	 * 
	 */	
	public class ClassUtil
	{
		/**
		 * 获取包路径字符串  a.b.class 
		 * @param obj 对象
		 * @return 类型字符串
		 * 
		 */		
		public static function getPackageString(obj:Object):String
		{
			var result:String = getQualifiedClassName(obj);
			return result.replace("::", ".");
		}
		
		/**
		 * 获取类型字符串 class 
		 * @param obj 对象
		 * @return 类型字符串
		 * 
		 */		
		public static function getClassString(obj:Object):String
		{
			var result:String = getQualifiedClassName(obj);
			return result.indexOf("::") >= 0?result.split("::")[1]:result;
		}
	}
}