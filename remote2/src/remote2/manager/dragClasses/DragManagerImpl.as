package remote2.manager.dragClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import remote2.core.DragSource;
	import remote2.core.RemoteGlobals;
	import remote2.manager.IDragManager;
	
	/**
	 * @private
	 *
	 * @author xujunjie
	 * @date 2013-5-27 下午10:19:21
	 * 
	 */	
	public class DragManagerImpl implements IDragManager
	{
		private var _isDraging:Boolean;
		
		private var _dragProxy:DragProxy;
		
		public function get isDragging():Boolean
		{
			return _isDraging;
		}
		
		public function doDrag(
			dragInitiator:DisplayObject, 
			dragSource:DragSource, 
			mouseEvent:MouseEvent, 
			dragImage:DisplayObject=null, 
			xOffset:Number=0, 
			yOffset:Number=0, 
			imageAlpha:Number=0.5, 
			allowMove:Boolean=true):void
		{
			if(_isDraging)
				return;
			_dragProxy = new DragProxy(dragInitiator, dragSource);
			if(dragImage == null)
			{
				var bmpData:BitmapData = new BitmapData(dragInitiator.width, dragInitiator.height, false, 0);
				bmpData.draw(dragInitiator);
				dragImage = new Bitmap(bmpData);
			}
			dragImage.alpha = imageAlpha;
			_dragProxy.xoffset = xOffset;
			_dragProxy.yoffset = yOffset;
			_dragProxy.x = RemoteGlobals.popupLayer.mouseX + xOffset;
			_dragProxy.y = RemoteGlobals.popupLayer.mouseY + yOffset;
			_dragProxy.addChild(dragImage);
			RemoteGlobals.popupLayer.addChild(_dragProxy);
		}
		
		public function acceptDragDrop(target:InteractiveObject):void
		{
			if(_dragProxy)
				_dragProxy.dropTarget2 = target;
		}
		
		public function endDrag():void
		{
			if(_dragProxy)
			{
				_dragProxy.endDrag();
				RemoteGlobals.popupLayer.removeChild(_dragProxy);
			}
			_isDraging = false;
		}
	}
}