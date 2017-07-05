package remote2.utils
{
	
	/**
	 *
	 *
	 * @author xujunjie
	 * @date 2014-11-27
	 */
	public class RegExpUtil
	{
		public static function Escape(str:String):String
		{
			return str.replace(/[\\\*\+\?\|\{\[\(\)\^\$\.\#\ ]/g, "\\$&");
		}
	}
}