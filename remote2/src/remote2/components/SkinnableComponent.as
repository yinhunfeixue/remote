package remote2.components
{
	import mx.utils.StringUtil;
	
	import remote2.core.ISkin;
	import remote2.core.remote_internal;
	import remote2.events.StateEvent;
	import remote2.manager.StyleManager;
	
	use namespace remote_internal;
	
	[SkinState("normal")]
	
	[SkinState("disabled")]
	
	/**
	 * 具有皮肤的组件基类
	 * <b>具有皮肤的自定义组件应该使用此类为基类</b>
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class SkinnableComponent extends Group
	{
		private var _skin:ISkin;
		private var _currentState:String;
		private var _skinClass:Class;
		private var _skinClassChanged:Boolean;
		
		private var _styleName:String;
		
		/**
		 *  样式管理器，指向StyleManager.instance单例
		 */		
		protected var styleManager:StyleManager;
		
		public function SkinnableComponent()
		{
			super();
			styleManager = StyleManager.instance;
			autoDrawRepsonse = true;
		}
		
		/**
		 * 获取皮肤中的对象 
		 * @param id 对象ID
		 * @param require 是否必须存在，若此参数为true,但是皮肤中又未定义，会报错
		 * @return 
		 * 
		 */		
		protected function findSkinPart(id:String, requisite:Boolean = true):*
		{
			if(_skin != null)
			{
				if((_skin as Object).hasOwnProperty(id) && _skin[id] != null)
					return _skin[id];
				else if(requisite)
					throw new Error(StringUtil.substitute("{0} is requisite", id));
			}
			return null;
		}
		
		/**
		 * 当前状态，一般用于皮肤控制
		 */		
		public function get currentState():String
		{
			return _currentState;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			if(_skinClass == null)
			{
				if(styleManager != null)
					skinClass = styleManager.getClass(this);
			}
			validateSkinState();
		}
		
		/**
		 *  
		 * @param force 是否强制，如果为true,则不论当前状态是否和新状态都会重绘皮肤
		 * 
		 */		
		remote_internal function validateSkinState(force:Boolean = false):void
		{
			if(inited)
			{
				var oldState:String = _currentState;
				_currentState = getCurrentState();
				if(oldState != _currentState || force)
				{
					if(skin)
						skin.styleChange(_currentState, oldState);
					invalidateDisplayList();
					dispatchEventWithCheck(new StateEvent(StateEvent.STATE_CHANGED, _currentState, oldState));
				}
			}
		}
		
		/**
		 * @private 
		 * 
		 */		
		protected function getCurrentState():String
		{
			return enabled?"normal":"disabled";
		}
		
		/**
		 * 皮肤添加后执行的方法 
		 * 
		 */		
		protected function onSkinAdded():void
		{
			
		}
		
		/**
		 * 皮肤移除前执行的方法 
		 * 
		 */		
		protected function onSkinRemoveing():void
		{
			
		}
		/**
		 * @inheritDoc
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_skinClassChanged)
			{
				_skinClassChanged = false;
				if(_skinClass != null)
					setSkin(new _skinClass());
				else
					setSkin(null);
			}
		}
		/**
		 * @inheritDoc
		 */	
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			if(_skin)
				_skin.updateDisplayList(unscaleWidth, unscaleHeight);
		}
		
		private function getPartFromSkin(id:String):Object
		{
			if(_skin != null)
				return _skin[id];
			else
				return null;
		}
		
		/**
		 * 皮肤 
		 */
		public function get skin():ISkin
		{
			return _skin;
		}
		
		/**
		 * 皮肤类 
		 * 
		 */		
		public function set skinClass(value:Class):void
		{
			if(_skinClass != value)
			{
				_skinClass = value;
				_skinClassChanged = true;
				invalidateProperties();
			}
		}
		
		public function get skinClass():Class
		{
			return _skinClass;
		}
		
		/**
		 * @private
		 */
		private function setSkin(value:ISkin):void
		{
			if(_skin != value)
			{
				if(_skin)
				{
					onSkinRemoveing();
					_skin.uninstall();
					_skin.target = null;
				}
				_skin = value;
				if(_skin)
				{
					_skin.target = this;
					_skin.install();
					_skin.styleChange(currentState, null);
					onSkinAdded();
					invalidateDisplayList();
				}
			}
		}
		/**
		 * @inheritDoc
		 */	
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			validateSkinState();
		}

		/**
		 * 样式名 
		 */
		public function get styleName():String
		{
			return _styleName;
		}

		/**
		 * @private
		 */
		public function set styleName(value:String):void
		{
			_styleName = value;
		}

	}
}