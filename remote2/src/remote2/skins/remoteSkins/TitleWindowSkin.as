package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import remote2.components.Button;
	import remote2.components.Group;
	import remote2.components.RichText;
	import remote2.components.SkinnableComponent;
	import remote2.components.TitleWindow;
	import remote2.components.ToggleButton;
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class TitleWindowSkin extends RemoteSkin
	{
		public var buttonClose:Button;
		
		public var moveArea:Group;
		
		public var contentGroup:Group;
		
		public var buttonSize:ToggleButton;
		
		private var _labelTitle:RichText;

		protected var headHeight:Number;
		
		private var _drawHeight:Number = NaN;
		
		public function get labelTitle():RichText
		{
			if(_labelTitle == null)
			{
				_labelTitle = new RichText();
				_labelTitle.fontFamily = defaultFont;
				_labelTitle.verticalCenter = 0;
				_labelTitle.left = 10;
				moveArea.addChild(_labelTitle);
			}
			return _labelTitle;
		}
		
		public function TitleWindowSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			target.filters = [new DropShadowFilter(5, 45, 0, 1, 5, 5, 0.15)];
			
			headHeight = 30;
			
			contentGroup = (target as TitleWindow).contentGroup;
			contentGroup.top = headHeight;
			contentGroup.bottom = 0;
			contentGroup.percentWidth = 100;
			
			moveArea = new Group();
			moveArea.mouseChildren = false;
			moveArea.left = 0;
			moveArea.right = 0;
			moveArea.height = headHeight;
			target.addChild(moveArea);
			
			buttonClose = new Button();
			buttonClose.right = 10;
			buttonClose.width = 15;
			buttonClose.height = 15;
			buttonClose.top = (headHeight - buttonClose.height) / 2;
			buttonClose.skinClass = TitleWindowCloseButtonSkin;
			target.addChild(buttonClose);
			
			buttonSize = new ToggleButton();
			buttonSize.skinClass = TitleWindowSizeButtonSkin;
			buttonSize.right = 30;
			buttonSize.width = 15;
			buttonSize.height = 15;
			buttonSize.top = (headHeight - buttonClose.height) / 2;
			target.addChild(buttonSize);
		}
		
		override public function uninstall():void
		{
			target.removeChild(moveArea);
			target.removeChild(buttonClose);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			
			var useHeight:Number = isNaN(_drawHeight)?unscaleHeight:_drawHeight;
			
			var g:Graphics = target.graphics;
			g.lineStyle(1, 0xa9b0b2);
			g.beginFill(0xfafafa);
			g.drawRect(0, 0, unscaleWidth, useHeight);
			g.endFill();
			
			var g2:Graphics = moveArea.graphics;
			g2.clear();
			g2.beginFill(0xFFFDE8);
			g2.drawRect(0, 0, moveArea.width, moveArea.height);
			g2.endFill();
			
			var m:Matrix = new Matrix();
			m.createGradientBox(moveArea.width, moveArea.height, Math.PI / 2);
			g2.lineStyle(1, 0xa9b0b2);
			g2.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xF2F2F2,], [1, 0.2], [0, 255], m);
			g2.drawRect(0, 0, moveArea.width, moveArea.height);
			g2.endFill();
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			super.styleChange(newState, oldState);
			switch(newState)
			{
				case "normalAndMini":
					contentGroup.visible = false;
					contentGroup.mouseEnabled = false;
					contentGroup.mouseChildren = false;
					target.mouseEnabled = false;
					_drawHeight = headHeight;
					break;
				default:
					contentGroup.visible = true;
					contentGroup.mouseEnabled = true;
					contentGroup.mouseChildren = true;
					target.mouseEnabled = true;
					_drawHeight = NaN;
					break;
			}
		}
		
	}
}