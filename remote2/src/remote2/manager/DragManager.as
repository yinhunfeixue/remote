package remote2.manager
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import remote2.core.DragSource;
	import remote2.core.Injector;
	import remote2.core.RemoteGlobals;
	
	/**
	 * 拖动管理器
	 *
	 * @author xujunjie
	 * @date 2013-5-28 下午10:26:45
	 * 
	 * @see remote2.core.DragControl
	 */	
	public class DragManager
	{
		private static function get instance():IDragManager
		{
			return Injector.getInstance(RemoteGlobals.KEY_DRAG_MANAGER) as IDragManager;
		}
		
		/**
		 * 是否下在进行拖动操作 
		 * 
		 */		
		public static function get isDragging():Boolean
		{
			return instance.isDragging;
		}
		
		/**
		 * 启动拖动操作 
		 * @param dragInitiator 指定启动拖动的组件的 IUIComponent
		 * @param dragSource 拖动携带的数据
		 * @param mouseEvent 与启动拖动相关的鼠标信息的 MouseEvent
		 * @param dragImage  要拖动的图像。此参数是可选的。如果省略此参数，则在拖放操作期间将使用标准的拖动矩形。如果指定了某个图像，则必须显式设置该图像的高度和宽度，否则此图像将不显示。
		 * @param xOffset 用于指定 dragImage 的 x 偏移（以像素为单位）的数字。此参数是可选的。如果省略此参数，将在拖动启动器的左上角显示拖动代理。该偏移是指从拖动代理的左边缘到拖动启动器的左边缘的距离（以像素为单位），通常为负数。
		 * @param yOffset 用于指定 dragImage 的 y 偏移（以像素为单位）的数字。此参数是可选的。如果省略此参数，将在拖动启动器的左上角显示拖动代理。该偏移是指从拖动代理的上边缘到拖动启动器的上边缘的距离（以像素为单位），通常为负数。
		 * @param imageAlpha 用于指定拖动图像所用的 Alpha 值的数字。此参数是可选的。如果省略此参数，则默认的 Alpha 值为 0.5。值为 0.0 表示图像是透明的；值为 1.0 表示图像完全不透明。
		 * @param allowMove 指示是否允许放置目标移动所拖动的数据。
		 * 
		 */	
		public static function doDrag(dragInitiator:DisplayObject, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:DisplayObject=null, xOffset:Number=0, yOffset:Number=0, imageAlpha:Number=0.5, allowMove:Boolean=true):void
		{
			instance.doDrag(dragInitiator, dragSource, mouseEvent, dragImage, xOffset, yOffset, imageAlpha, allowMove);
		}
		
		/**
		 * 设置接受拖放操作 
		 * @param target 接受拖放操作的对象
		 * 
		 */		
		public static function acceptDragDrop(target:InteractiveObject):void
		{
			instance.acceptDragDrop(target);
		}
		
		/**
		 * 结束拖放操作 
		 * 
		 */	
		public static function endDrag():void
		{
			instance.endDrag();
		}
	}
}