package remote2.skins.remoteSkins
{
	import remote2.components.Alert;
	import remote2.components.Group;
	import remote2.components.Image;
	import remote2.components.Label;
	import remote2.components.RichText;
	import remote2.layouts.HorizontalAlign;
	import remote2.layouts.HorizontalLayout;
	import remote2.layouts.VerticalLayout;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-26
	 *
	 * */
	public class AlertSkin extends TitleWindowSkin
	{
		public var labelDisplay:Label;
		
		public var imageIcon:Image;
		
		public var groupButtons:Group;
		
		public function AlertSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			var vl:VerticalLayout = new VerticalLayout();
			vl.paddingTop = 20;
			vl.paddingBottom = 20;
			vl.paddingLeft = 20;
			vl.paddingRight = 20;
			vl.gap = 20;
			vl.horizontalAlign = HorizontalAlign.CENTER;
			contentGroup.layout = vl;
			
			labelDisplay = new Label();
			labelDisplay.maxMeasureWidth = 300;
			contentGroup.addChild(labelDisplay);
			
			groupButtons = new Group();
			var ll:HorizontalLayout = new HorizontalLayout();
			ll.gap = 10;
			groupButtons.layout = ll;
			contentGroup.addChild(groupButtons);
		}
	}
}