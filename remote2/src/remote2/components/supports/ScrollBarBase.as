package remote2.components.supports
{
	import remote2.components.Button;
	import remote2.events.RemoteEvent;
	
	/**
	 * 滚动条基类
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class ScrollBarBase extends SliderBase
	{

		/**
		 * 减量按钮
		 * 
		 */		
		protected function get decrementButton():Button
		{
			return findSkinPart("decrementButton");
		}
		
		/**
		 * 增量按钮 
		 * 
		 */		
		protected function get incrementButton():Button
		{
			return findSkinPart("incrementButton");
		}
		
		private var _stepInterval:uint = 10;
		
		public function ScrollBarBase()
		{
			super();
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			decrementButton.addEventListener(RemoteEvent.BUTTON_DOWN, decrementButton_buttonHandler);
			incrementButton.addEventListener(RemoteEvent.BUTTON_DOWN, incrementButton_buttonHandler);
			decrementButton.autoRepeat = true;
			incrementButton.autoRepeat = true;
		}
		
		protected function incrementButton_buttonHandler(event:RemoteEvent):void
		{
			if(value < maximum)
				value += stepSize * _stepInterval;
		}
		
		protected function decrementButton_buttonHandler(event:RemoteEvent):void
		{
			if(value > minimum)
				value -= stepSize * _stepInterval;
		}
		
		override protected function onSkinRemoveing():void
		{
			decrementButton.removeEventListener(RemoteEvent.BUTTON_DOWN, decrementButton_buttonHandler);
			incrementButton.removeEventListener(RemoteEvent.BUTTON_DOWN, incrementButton_buttonHandler);
			super.onSkinRemoveing();
		}

		/**
		 * 点击减量/增量按钮时步进倍率 
		 */
		public function get stepInterval():uint
		{
			return _stepInterval;
		}

		/**
		 * @private
		 */
		public function set stepInterval(value:uint):void
		{
			_stepInterval = value;
		}

	}
}