package remote2.skins.remoteSkins
{
	import flash.display.Graphics;
	
	import remote2.components.Button;
	
	/**
	 * 
	 *
	 * @author xujunjie
	 * @date 2013-5-26 下午5:46:06
	 * 
	 */	
	public class SizerSkin extends RemoteSkin
	{
		public var buttonTopLeft:Button;
		public var buttonTopCenter:Button;
		public var buttonTopRight:Button;
		public var buttonMiddleLeft:Button;
		public var buttonMiddleRight:Button;
		public var buttonBottomLeft:Button;
		public var buttonBottomCenter:Button;
		public var buttonBottomRight:Button;
		
		public function SizerSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			
			buttonTopLeft = new Button();
			buttonTopLeft.skinClass = SizerButtonSkin;
			buttonTopLeft.width = 0;
			buttonTopLeft.height = 0;
			target.addChild(buttonTopLeft);
			
			buttonTopCenter = new Button();
			buttonTopCenter.skinClass = SizerButtonSkin;
			buttonTopCenter.width = 0;
			buttonTopCenter.height = 0;
			target.addChild(buttonTopCenter);
			
			buttonTopRight = new Button();
			buttonTopRight.skinClass = SizerButtonSkin;
			buttonTopRight.width = 0;
			buttonTopRight.height = 0;
			target.addChild(buttonTopRight);
			
			buttonMiddleLeft = new Button();
			buttonMiddleLeft.skinClass = SizerButtonSkin;
			buttonMiddleLeft.width = 0;
			buttonMiddleLeft.height = 0;
			target.addChild(buttonMiddleLeft);
			
			buttonMiddleRight = new Button();
			buttonMiddleRight.skinClass = SizerButtonSkin;
			buttonMiddleRight.width = 0;
			buttonMiddleRight.height = 0;
			target.addChild(buttonMiddleRight);
			
			buttonBottomLeft = new Button();
			buttonBottomLeft.skinClass = SizerButtonSkin;
			buttonBottomLeft.width = 0;
			buttonBottomLeft.height = 0;
			target.addChild(buttonBottomLeft);
			
			buttonBottomCenter = new Button();
			buttonBottomCenter.skinClass = SizerButtonSkin;
			buttonBottomCenter.width = 0;
			buttonBottomCenter.height = 0;
			target.addChild(buttonBottomCenter);
			
			buttonBottomRight = new Button();
			buttonBottomRight.skinClass = SizerButtonSkin;
			buttonBottomRight.width = 0;
			buttonBottomRight.height = 0;
			target.addChild(buttonBottomRight);
		}
		
		override public function uninstall():void
		{
			target.removeChild(buttonTopLeft);
			target.removeChild(buttonTopCenter);
			target.removeChild(buttonTopRight);
			target.removeChild(buttonMiddleLeft);
			target.removeChild(buttonMiddleRight);
			target.removeChild(buttonBottomLeft);
			target.removeChild(buttonBottomCenter);
			target.removeChild(buttonBottomRight);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			g.clear();
			g.lineStyle(1);
			//g.drawRect(0, 0, unscaleWidth, unscaleHeight);
		}
		
	}
}