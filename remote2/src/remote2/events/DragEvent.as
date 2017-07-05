////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package remote2.events
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import remote2.core.DragSource;

	/**
	 * 拖动相关事件 
	 * @author xujunjie
	 * 
	 */	
	public class DragEvent extends MouseEvent
	{
		public static const DRAG_COMPLETE:String = "dragComplete";
		public static const DRAG_DROP:String = "dragDrop";
		public static const DRAG_ENTER:String = "dragEnter";
		public static const DRAG_EXIT:String = "dragExit";
		public static const DRAG_OVER:String = "dragOver";
		public static const DRAG_START:String = "dragStart";
		
		/**
		 * 触发拖动的对象
		 */		
		public var dragInitiator:DisplayObject;
		
		/**
		 * 拖动操作携带的数据 
		 */		
		public var dragSource:DragSource;
		
		/**
		 *  
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * @param dragInitiator
		 * @param dragSource
		 * @param ctrlKey
		 * @param altKey
		 * @param shiftKey
		 * 
		 */		
		public function DragEvent(type:String, bubbles:Boolean = false,
								  cancelable:Boolean = true,
								  dragInitiator:DisplayObject = null,
								  dragSource:DragSource = null,
								  ctrlKey:Boolean = false,
								  altKey:Boolean = false,
								  shiftKey:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.dragInitiator = dragInitiator;
			this.dragSource = dragSource;
			this.ctrlKey = ctrlKey;
			this.altKey = altKey;
			this.shiftKey = shiftKey;
		}

		override public function clone():Event
		{
			var cloneEvent:DragEvent = new DragEvent(type, bubbles, cancelable, 
				dragInitiator, dragSource,
				ctrlKey,
				altKey, shiftKey);
			
			cloneEvent.relatedObject = this.relatedObject;
			cloneEvent.localX = this.localX;
			cloneEvent.localY = this.localY;
			
			return cloneEvent;
		}
	}
	
}
