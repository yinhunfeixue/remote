package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import remote2.components.Label;

	public class ComboBoxButtonSkin extends RemoteSkin
	{
		public var labelDisplay:Label
		
		protected var _lightColor:uint = 0xffffff;
		protected var _lightAlpha:Number = 1;
		protected var _darkColor:uint = 0xcccccc;
		protected var _drakAlpha:Number = 1;
		protected var _borderColor:uint = 0xADB6B8;
		protected var _corner:Number = 4;
		
		public function ComboBoxButtonSkin()
		{
			super();
		}
		
		override public function install():void
		{
			super.install();
			labelDisplay = new Label();
			labelDisplay.left = 5;
			labelDisplay.right = 15;
			labelDisplay.verticalCenter = 0;
			target.addChild(labelDisplay);
		}
		
		override public function uninstall():void
		{
			target.removeChild(labelDisplay);
			super.uninstall();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaleWidth, unscaleHeight,  Math.PI / 2);
			var g:Graphics = target.graphics;
			
			g.beginFill(themeColor);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, _corner, _corner);
			g.endFill();
			
			g.lineStyle(1, _borderColor, 1);
			g.beginGradientFill(GradientType.LINEAR, [_lightColor, _darkColor], [_lightAlpha, _drakAlpha], [0, 255], m);
			g.drawRoundRect(0, 0, unscaleWidth, unscaleHeight, _corner, _corner);
			g.endFill();
			
			var separtX:Number = unscaleWidth - 20;
			if(separtX > 0)
			{
				g.moveTo(separtX, 0);
				g.lineTo(separtX, unscaleHeight);
				var points:Vector.<Point> = new Vector.<Point>();
				points.push(new Point(unscaleWidth - 14, unscaleHeight / 2 - 3), new Point(unscaleWidth - 6, unscaleHeight / 2 - 3), new Point(unscaleWidth - 10, unscaleHeight /2 + 4));
				g.lineStyle();
				g.beginFill(0x666666);
				g.moveTo(points[2].x, points[2].y);
				for(var i:int = 0; i < points.length; i++)
				{
					g.lineTo(points[i].x, points[i].y);
				}
				g.endFill();
			}
		}
		
		override public function styleChange(newState:String, oldState:String):void
		{
			switch(newState)
			{
				case "disabled":
					_lightColor = 0xcccccc;
					_darkColor = 0xcccccc;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.6;
					break;
				case "down":
					_lightColor = 0xcccccc;
					_darkColor = 0xffffff;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.4;
					break;
				case "over":
					_lightColor = 0xffffff;
					_darkColor = 0xeeeeee;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.8;
					_drakAlpha = 0.6;
					break;
				default:
					_lightColor = 0xffffff;
					_darkColor = 0xcccccc;
					_borderColor = 0x8B9194;
					_lightAlpha = 0.6;
					_drakAlpha = 0.4;
					break;
			}
		}
		
	}
}