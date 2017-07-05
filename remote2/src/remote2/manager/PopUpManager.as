package remote2.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import remote2.components.Modal;
	import remote2.components.UIComponent;
	import remote2.core.IPopUp;
	import remote2.core.RemoteGlobals;
	import remote2.events.RemoteEvent;
	
	/**
	 * 弹出管理 
	 * 
	 * @date 2013-5-17
	 * 
	 * @author xujunjie
	 * 
	 */	
	public class PopUpManager
	{
		private static var _modalMask:Dictionary;
		
		/**
		 * 弹出显示对象
		 * @param popUp 要弹出的显示对象
		 * @param modal  如果为 true，则该窗口为模态窗口，也就是说在删除该窗口之前，用户将无法与其它弹出窗口交互
		 * 
		 */		
		public static function addPopUp(popUp:DisplayObject, modal:Boolean = false):void
		{
			var	parent:DisplayObjectContainer= RemoteGlobals.popupLayer;
			if(!parent.contains(popUp))
			{
				parent.addChild(popUp);
				if(modal)
					addModal(popUp);
				if(popUp is IPopUp)
					(popUp as IPopUp).isPopup = true;
			}
		}
		
		/**
		 * 创建一个显示对象，并弹出
		 * @param type 要为弹出窗口创建的对象的类
		 * @param modal 如果为 true，则该窗口为模态窗口，也就是说在删除该窗口之前，用户将无法与其它弹出窗口交互
		 * @return 对新的显示对象的引用
		 * 
		 */		
		public static function createPopUp(type:Class, modal:Boolean = false):DisplayObject
		{
			var window:DisplayObject = new type();
			addPopUp(window, modal);
			return window;
		}
		
		/**
		 * 使显示对象相对于父对象居中
		 * <br/>
		 * 此方法也可以用于非PopupManger弹出的对象
		 * @param popUp 显示对象
		 * 
		 */		
		public static function centerPopUp(popUp:DisplayObject):void
		{
			if(popUp is UIComponent && !(popUp as UIComponent).updateCompletePendingFlag)
			{
				(popUp as UIComponent).addEventListener(RemoteEvent.CREATION_COMPLETE, popup_CreateCompleteHandler, false, 0, true);
			}
			else
			{
				var parent:DisplayObjectContainer = popUp.parent;
				if(parent == null)
					parent = RemoteGlobals.popupLayer;
				var point:Point = new Point(Math.round((parent.width - popUp.width) / 2), Math.round((parent.height - popUp.height) / 2));
				popUp.x = point.x;
				popUp.y = point.y;
			}
		}
		
		protected static function popup_CreateCompleteHandler(event:Event):void
		{
			centerPopUp(event.currentTarget as DisplayObject);
		}
		
		/**
		 * 删除由 createPopUp() 或 addPopUp() 方法弹出的显示对象
		 * @param popUp 要移除的显示对象
		 * 
		 */		
		public static function removePopUp(popUp:DisplayObject):void
		{
			var parent:DisplayObjectContainer = RemoteGlobals.popupLayer;
			if(parent.contains(popUp))
				parent.removeChild(popUp);
			removeModal(popUp);
		}
		
		private static function addModal(popUp:DisplayObject):void
		{
			if(_modalMask == null)
				_modalMask = new Dictionary();
			if(popUp.parent && !_modalMask[popUp])
			{
				var modal:Modal = new Modal();
				_modalMask[popUp] = modal;
				popUp.parent.addChildAt(modal, popUp.parent.getChildIndex(popUp));
			}
		} 
		
		private static function removeModal(popUp:DisplayObject):void
		{
			if(_modalMask == null)
				return;
			var modal:Modal = _modalMask[popUp];
			if(modal)
			{
				modal.parent.removeChild(modal);
				delete _modalMask[popUp];
			}
		}
	}
}