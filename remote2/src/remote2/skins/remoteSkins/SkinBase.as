package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	import remote2.components.SkinnableComponent;
	
	/**
	 * 深复制接口 
	 * @author xjj
	 * 
	 */	
	public class SkinBase
	{
		private var _target:SkinnableComponent;
		
		public function SkinBase()
		{
		}
		
		public function set target(value:SkinnableComponent):void
		{
			_target = value;
		}
		
		public function get target():SkinnableComponent
		{
			return _target;
		}
	}
}