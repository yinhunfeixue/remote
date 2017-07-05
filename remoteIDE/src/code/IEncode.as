package code
{
	
	/**
	 * 编码接口
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public interface IEncode
	{
		/**
		 * 编码 
		 * @param object 要编码的对象
		 * @return 代码字符串
		 * 
		 */		
		function encode(target:Object):String;
	}
}