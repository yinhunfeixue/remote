package remote2.skins.remoteSkins
{
	import remote2.components.Button;
	import remote2.components.List;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-15
	 */	
	public class ComboBoxSkin extends RemoteSkin
	{
		public var comboButton:Button;
		public var dropList:List;
		
		public function ComboBoxSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			comboButton = new Button();
			comboButton.skinClass = ComboBoxButtonSkin;
			target.addChild(comboButton);
			
			dropList = new List();
			dropList.maxMeasureHeight = 200;
		}
		
		override public function uninstall():void
		{
			target.removeChild(comboButton);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			comboButton.width = unscaleWidth;
			comboButton.height = unscaleHeight;
		}
		
	}
}