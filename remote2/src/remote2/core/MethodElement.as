package remote2.core
{
	/**
	 * 存储一个方法和参数
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-14
	 * */
	public class MethodElement
	{
		public var method:Function;
		public var args:Array;
		public function MethodElement(method:Function, args:Array = null)
		{
			this.method = method;
			this.args = args;
		}
	}
}