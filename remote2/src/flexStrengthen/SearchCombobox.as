package flexStrengthen
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import spark.components.ComboBox;
	import spark.events.TextOperationEvent;
	
	import remote2.utils.StringUtil2;
	
	//import skins.UnFixedWidthComboBoxSkin;
	
	[Style(name="listMaxHeight", inherit="no", type="Number")]
	public class SearchCombobox extends ComboBox
	{
		private var _realDataProvider:IList;
		
		public function SearchCombobox()
		{
			super();
			itemMatchingFunction = machFunction;
			//setStyle("skinClass", UnFixedWidthComboBoxSkin);
			
		}
		
		private function machFunction(comboBox:ComboBox, inputText:String):Vector.<int>
		{
			return new Vector.<int>();
//			var result:Vector.<int> = new Vector.<int>();
//			if(comboBox != null || comboBox.dataProvider != null)
//			{
//				for (var i:int = 0; i < comboBox.dataProvider.length; i++) 
//				{
//					var str:String = itemToLabel(comboBox.dataProvider.getItemAt(i)).toLowerCase();
//					if(str.search(inputText.toLowerCase()) >= 0)
//					{
//						result.push(i);
//						break;
//					}
//				}
//			}
//			return result;
		}
		
		public function reset():void
		{
			textInput.text = "";
			filteDataProvider();
		}
		
		override protected function textInput_changeHandler(event:TextOperationEvent):void
		{
			filteDataProvider();
			super.textInput_changeHandler(event);
		}
		
		private function filteDataProvider():void
		{
			if(_realDataProvider == null || textInput == null)
				dataProvider = _realDataProvider;
			else
			{
				var key:String = textInput.text;
				if(key != null && key.length > 0)
				{
					var reg:RegExp = new RegExp(textInput.text.toLowerCase());
					var array:Array = [];
					for each (var item:* in _realDataProvider) 
					{
						var itemLowerLabel:String = itemToLabel(item).toLowerCase();
						if(reg.test(itemLowerLabel) || reg.test(StringUtil2.getFirstWord(itemLowerLabel).toLowerCase()))
							array.push(item);
					}
					dataProvider = new ArrayCollection(array);
				}
				else
				{
					dataProvider = _realDataProvider;
				}
			}
			
			if(dataProvider == null || dataProvider.length == 0)
				closeDropDown(false);
		}
		
		
		public function get realDataProvider():IList
		{
			return _realDataProvider;
		}
		
		public function set realDataProvider(value:IList):void
		{
			_realDataProvider = value;
			filteDataProvider();
		}
		
	}
}