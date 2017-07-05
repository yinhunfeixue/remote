package test
{
	import flash.events.Event;
	
	import remote2.components.Image;
	import remote2.components.supports.ItemRenderBase;
	import remote2.core.DragControl;
	import remote2.core.DragSource;
	import remote2.events.DragEvent;
	import remote2.manager.DragManager;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-17
	 *
	 * */
	public class HeadItemRender extends ItemRenderBase
	{
		private function get imageUrl():String
		{
			if(data)
				return "../assets/" + data + ".png";
			return "";
		}
		
		private var _image:Image;
		private var _imageChanged:Boolean;
		
		private var _dragControl:DragControl;
		
		public function HeadItemRender()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_image = new Image();
			addChild(_image);
			
			addEventListener(DragEvent.DRAG_START, image_dragStartHandler);
			
			_dragControl = new DragControl(this);
			_dragControl.allowDrag();
		}
		
		protected function image_dragStartHandler(event:DragEvent):void
		{
			var source:DragSource = new DragSource();
			source.addData(data, "headImage");
			DragManager.doDrag(this, source, event, null, -event.localX, -event.localY);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_imageChanged)
			{
				_imageChanged = false;
				_image.source = imageUrl;
				toolTip = data.toString();
			}
		}
		
		override public function set data(value:*):void
		{
			super.data = value;
			_imageChanged = true;
			invalidateProperties();
		}
		
	}
	
}