package modules.select
{
	import remote2.collections.ArrayCollection;
	import remote2.components.Button;
	import remote2.components.CheckBox;
	import remote2.components.ComboBox;
	import remote2.components.HSlider;
	import remote2.components.Label;
	import remote2.components.List;
	import remote2.components.RadioButton;
	import remote2.components.TextInput;
	import remote2.components.ToggleButton;
	import remote2.components.VSlider;
	import remote2.geom.Size;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-30
	 *
	 * */
	public class SelectorList extends List
	{
		public function SelectorList()
		{
			super();
			
			itemRender = SelectorItemRender;
			dataProvider = new ArrayCollection(
				[
					new SelectorData("modules/icons/Label.png", Label, null, {"text":"标签","fontFamily":"Simsun"}),
					new SelectorData("modules/icons/Button.png", Button, null, {"label":"按钮"}),
					new SelectorData("modules/icons/TextInput.png", TextInput, new Size(100, 20)),
					new SelectorData("modules/icons/CheckBox.png", CheckBox, new Size(15, 20)),
					new SelectorData("modules/icons/ComboBox.png", ComboBox, new Size(100, 20)),
					new SelectorData("modules/icons/RadioButton.png", RadioButton, new Size(15, 20)),
					new SelectorData("modules/icons/HSlider.png", HSlider), 
					new SelectorData("modules/icons/VSlider.png", VSlider),
					new SelectorData("modules/icons/ToggleButton.png", ToggleButton, null,{"label":"切换按钮"}),
				]
			);
			
		}
	}
}