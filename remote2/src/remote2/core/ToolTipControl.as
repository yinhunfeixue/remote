package remote2.core
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import remote2.manager.IToolTipManager;

	/**
	 * tooltip代理控制器
	 * <br/>
	 * 需要给某个显示对象实现tooltip功能时，按以下步聚进行
	 * <ol>
	 * <li>创建ToolTipObject实例</li>
	 * <li>把显示对象的引用赋给ToolTipObject实例的target属性</li>
	 * <li>设置ToolTipObject实例的toolTip属性</li>
	 * </ol> 
	 * @author xujunjie
	 * 
	 */	
	public class ToolTipControl
	{
		private var _target:InteractiveObject;
		
		private var _toolTip:String;
		
		private var _manager:IToolTipManager;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function ToolTipControl()
		{
			_manager = Injector.getInstance(RemoteGlobals.KEY_TOOLTIP_MANAGER);
		}
		
		private function addListener():void
		{
			_target.addEventListener(MouseEvent.ROLL_OVER, target_mouseRollOverHandler);
			_target.addEventListener(MouseEvent.ROLL_OUT, target_rollOutHandler);
		}
		
		protected function target_rollOutHandler(event:MouseEvent):void
		{
			if(_manager.currentTarget == target)
				_manager.hide(target as IToolTipElement);
			var parentElement:IToolTipElement = findParentToolTipObject();
			if(parentElement != null)
				_manager.show(parentElement, parentElement.toolTip);
		}
		
		protected function target_mouseRollOverHandler(event:MouseEvent):void
		{
			if(toolTip != null)
				_manager.show(target as IToolTipElement, toolTip);
		}
		
		/**
		 * 查找具有toolTip功能，且提示信息不为空，离自己最近的父对象
		 * 
		 */		
		protected function findParentToolTipObject():IToolTipElement
		{
			if(target)
			{
				var result:DisplayObject = target.parent;
				while(result != null)
				{
					var element:IToolTipElement = result as IToolTipElement;
					if(element != null && element.toolTip != null && element.toolTip.length > 0)
						return element;
					result = result.parent;
				}
			}
			return null;
		}
		
		private function removeListener():void
		{
			_target.removeEventListener(MouseEvent.ROLL_OVER, target_mouseRollOverHandler);
			_target.removeEventListener(MouseEvent.ROLL_OUT, target_rollOutHandler);
		}

		/**
		 * 和toolTip关联的显示对象 
		 */
		public function get target():InteractiveObject
		{
			return _target;
		}

		/**
		 * @private
		 */
		public function set target(value:InteractiveObject):void
		{
			if(_target != value)
			{
				if(_target != null)
				{
					removeListener();
					if(_manager.currentTarget == target)
						_manager.hide(target as IToolTipElement);
				}
				_target = value;
				if(_target != null)
				{
					addListener();
				}
			}
		}

		/**
		 * 提示内容 
		 */
		public function get toolTip():String
		{
			return _toolTip;
		}

		/**
		 * @private
		 */
		public function set toolTip(value:String):void
		{
			if(_toolTip != value)
			{
				_toolTip = value;
				if(_manager.currentTarget == target)
					_manager.show(target as IToolTipElement, toolTip);
			}
		}
	}
}