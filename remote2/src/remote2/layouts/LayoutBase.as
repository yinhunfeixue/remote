package remote2.layouts
{
	import remote2.components.Group;

	/**
	 * 布局基类 
	 * @author yinhunfeixue
	 * 
	 */	
	public class LayoutBase
	{
		private var _target:Group;
		
		public function LayoutBase()
		{
		}

		public function get target():Group
		{
			return _target;
		}

		public function set target(value:Group):void
		{
			_target = value;
		}

	}
}