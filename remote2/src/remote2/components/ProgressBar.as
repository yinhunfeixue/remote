package remote2.components
{
	import remote2.core.remote_internal;

	use namespace remote_internal;
	
	public class ProgressBar extends SkinnableComponent
	{
		private var _value:Number = 0;
		private var _maxValue:Number = 100;
		
		public function ProgressBar()
		{
			super();
		}
		
		public function setProgress(value:Number, maxValue:Number):void
		{
			if(value > maxValue)
				value = maxValue;
			
			_value = value;
			_maxValue = maxValue;
			validateSkinState(true);
		}
		
		override protected function measure():void
		{
			measuredWidth = 300;
			measuredHeight = 8;
		}

		public function get value():Number
		{
			return _value;
		}

		public function get maxValue():Number
		{
			return _maxValue;
		}


	}
}