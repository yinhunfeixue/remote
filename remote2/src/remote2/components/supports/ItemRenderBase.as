package remote2.components.supports
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import remote2.components.Group;
	import remote2.core.IItemRender;
	
	
	/**
	 * 数据项基类，定义了数据项属性，同时处理了选中和移上时的样式
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-17
	 *
	 * */
	public class ItemRenderBase extends Group implements IItemRender
	{
		private var _data:Object;
		
		private var _selected:Boolean;
		private var _hoverd:Boolean;
		private var _index:int;
		private var _label:String;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ItemRenderBase()
		{
			super();
			mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
		
		protected function rollOutHandler(event:MouseEvent):void
		{
			_hoverd = false;
			invalidateDisplayList();
		}
		
		protected function rollOverHandler(event:MouseEvent):void
		{
			_hoverd = true;
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(bgColor, 0.3);
			g.drawRect(0, 0, unscaleWidth, unscaleHeight);
			g.endFill();
		}
		
		private function get bgColor():uint
		{
			if(_selected)
				return 0x0000ee;
			else if(_hoverd)
				return 0x009900;
			return 0xffffff;
		}
		
		/**
		 * @inheritDoc
		 */			
		public function get data():*
		{
			return _data;
		}
		
		public function set data(value:*):void
		{
			_data = value;
		}
		/**
		 * @inheritDoc
		 */	
		public function get index():uint
		{
			return _index;
		}
		
		public function set index(value:uint):void
		{
			_index = value;
		}
		/**
		 * @inheritDoc
		 */	
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				invalidateDisplayList();
			}
		}
		/**
		 * @inheritDoc
		 */	
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

	}
}