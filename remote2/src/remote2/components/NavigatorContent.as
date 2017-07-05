package remote2.components
{
	/**
	 * 默认的ViewStack子项，重写了toString()方法，当label属性有值时，返回label的值，以设置选项卡按钮上显示的文字。<br/>
	 * <b>出于性能考虑，如果你的ViewStack子项是自定义类，建议你自行重写toString方法，而无需在外面额外套一层NavigatorContent</b>
	 *
	 * @author xujunjie
	 * @date 2013-5-19 下午8:51:54
	 * 
	 */	
	public class NavigatorContent extends Group
	{
		private var _label:String;
		
		/**
		 * 实例化 
		 * 
		 */		
		public function NavigatorContent()
		{
			super();
		}
		
		override public function toString():String
		{
			if(label)
				return label;
			return super.toString();
		}

		/**
		 * 在选项卡上显示的内容
		 * 
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