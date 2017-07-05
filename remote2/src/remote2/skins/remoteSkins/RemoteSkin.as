package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	import remote2.core.ISkin;
	
	
	/**
	 *
	 *
	 *
	 * @author 银魂飞雪
	 * @date 2013-5-2
	 * */
	public class RemoteSkin extends SkinBase implements ISkin
	{
		public static var themeColor:uint = 0xFFFDE8;
		public static var defaultFont:String = "宋体";
		
		public function RemoteSkin()
		{
			super();
		}
		
		public function install():void
		{
		}
		
		public function uninstall():void
		{
			var g:Graphics = target.graphics;
			g.clear();
		}
		
		public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			var g:Graphics = target.graphics;
			g.clear();
			
			g.beginFill(0, 0);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
		public function styleChange(newState:String, oldState:String):void
		{
		}
	}
}