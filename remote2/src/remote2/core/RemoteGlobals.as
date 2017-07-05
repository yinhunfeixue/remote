package remote2.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import remote2.components.SystemManager;
	
	/**
	 * remote的全局属性
	 * 包含
	 * <ul>
	 * 	<li>stage引用</li>
	 * <li>toolTip层（可在程序初始化时设置，仅能设置一次）</li>
	 * <li>popup弹出层（可在程序初始化时设置，仅能设置一次）</li>
	 * <li>topApplication层（可在程序初始化时设置，仅能设置一次）</li>
	 * </ul>
	 * @author yinhunfeixue
	 * 
	 */	
	public class RemoteGlobals
	{
		/**
		 * toolTipManager的全局注入标识 
		 */		
		public static const KEY_TOOLTIP_MANAGER:String = "remote::toolTipManager";
		
		/**
		 * toolTip类全局注入标识 
		 */		
		public static const KEY_TOOLTIP:String = "remote:toolTip";
		
		public static const KEY_DRAG_MANAGER:String = "remote::dragManager";
		
		private static var _stage:Stage;
		
		private static var _toolTipLayer:DisplayObjectContainer;
		
		private static var _topApplication:Object;
		
		private static var _popupLayer:DisplayObjectContainer;
		
		
		public static function init(stage:Stage):void
		{
			_stage = stage;
		}
		
		/**
		 * 舞台 
		 * 
		 */		
		public static function get stage():Stage
		{
			return _stage;
		}
		
		
		/**
		 * 设置TiP层，只能设置一次。设置成功后，以后的设置都是无效值
		 * 
		 */
		public static function get toolTipLayer():DisplayObjectContainer
		{
			return _toolTipLayer;
		}
		
		public static function set toolTipLayer(value:DisplayObjectContainer):void
		{
			if(_toolTipLayer == null)
				_toolTipLayer = value;
		}
		
		/**
		 * 顶级应用程序 
		 * 
		 */		
		public static function get topApplication():Object
		{
			return _topApplication;
		}
		
		public static function set topApplication(value:Object):void
		{
			if(_topApplication == null)
				_topApplication = value;
		}
		
		/**
		 * 弹出层 
		 */
		public static function get popupLayer():DisplayObjectContainer
		{
			return _popupLayer;
		}
		
		/**
		 * @private
		 */
		public static function set popupLayer(value:DisplayObjectContainer):void
		{
			if(_popupLayer == null)
				_popupLayer = value;
		}
		
	}
}