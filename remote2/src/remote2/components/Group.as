package remote2.components
{
	import remote2.components.supports.LayoutComponent;
	import remote2.core.remote_internal;
	import remote2.layouts.BasicLayout;
	import remote2.layouts.ILayout;
	
	use namespace remote_internal;
	
	/**
	 * 支持布局的容器，把实现ILayoutElement接口的对象添加为子对象时，子对象的布局属性才会生效
	 * 所有基础组件都是此类的子类
	 * @author xujunjie
	 * 
	 */	
	public class Group extends LayoutComponent
	{
		private var _layout:ILayout;
		
		public function Group()
		{
			super();
		}
		
		override protected function initialize():void
		{
			if(_layout == null)
			{
				_layout = new BasicLayout();
				_layout.target = this;
			}
			super.initialize();
		}
		
		override protected function measure():void
		{
			if(inited && _layout)
			{
				var oldMWidth:Number = layoutWidth;
				var oldMHeight:Number = layoutHeight;
				_layout.measure();
				if(!isNaN(oldMWidth))
					measuredWidth = oldMWidth;
				if(!isNaN(oldMHeight))
					measuredHeight = oldMHeight;
			}
			else
			{
				super.measure();
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			if(inited && _layout)
			{
				_layout.updateChildren(unscaleWidth, unscaleHeight);
			}
		}
		
		/**
		 * 要使用的布局实例 
		 * 
		 */		
		public function get layout():ILayout
		{
			return _layout;
		}
		
		public function set layout(value:ILayout):void
		{
			_layout = value;
			_layout.target = this;
			
			invalidateSize();
			invalidateDisplayList();
		}
		
	}
}