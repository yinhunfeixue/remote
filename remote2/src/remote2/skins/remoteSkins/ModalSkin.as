package remote2.skins.remoteSkins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class ModalSkin extends RemoteSkin
	{
		public function ModalSkin()
		{
			super();
		}
		
		override public function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = target.graphics;
			
			var r:Number = Math.sqrt(Math.pow(unscaleHeight, 2) + Math.pow(unscaleWidth, 2)) / 2;
			var center:Point = new Point(unscaleWidth / 2, unscaleHeight / 2);
			var m:Matrix = new Matrix();
			m.createGradientBox(r * 2, r * 2, 0, center.x - r, center.y - r);
			g.beginGradientFill(GradientType.RADIAL, [0xffffff, 0xffffff, 0xffffff], [0.8, 0.8, 0.7], [0, 150,255], m);
			g.drawCircle(center.x, center.y, r);
			g.endFill();
		}
	}
}