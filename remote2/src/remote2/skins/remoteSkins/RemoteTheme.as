package remote2.skins.remoteSkins
{
	import remote2.components.Alert;
	import remote2.components.Button;
	import remote2.components.ButtonBar;
	import remote2.components.ButtonBarItemRender;
	import remote2.components.CheckBox;
	import remote2.components.ComboBox;
	import remote2.components.HScrollBar;
	import remote2.components.HSlider;
	import remote2.components.Image;
	import remote2.components.Modal;
	import remote2.components.ProgressBar;
	import remote2.components.RadioButton;
	import remote2.components.Scroller;
	import remote2.components.Sizer;
	import remote2.components.SkinnableComponent;
	import remote2.components.TextArea;
	import remote2.components.TextInput;
	import remote2.components.TitleWindow;
	import remote2.components.ToggleButton;
	import remote2.components.ToolTip;
	import remote2.components.VScrollBar;
	import remote2.components.VSlider;
	import remote2.skins.Theme;
	
	public class RemoteTheme extends Theme
	{
		public function RemoteTheme()
		{
			super();
			mapSkin(Button, ButtonSkin);
			mapSkin(ToggleButton, ToggleButtonSkin);
			mapSkin(RadioButton, RadioButtonSkin);
			mapSkin(CheckBox, CheckBoxSkin);
			mapSkin(SkinnableComponent, SkinnableComponentSkin);
			mapSkin(HSlider, HSliderSkin);
			mapSkin(VSlider, VSliderSKin);
			mapSkin(ToolTip, ToolTipSkin);
			mapSkin(HScrollBar, HScrollBarSkin);
			mapSkin(VScrollBar, VScrollBarSkin);
			mapSkin(TitleWindow, TitleWindowSkin);
			mapSkin(Scroller, ScrollerSkin);
			mapSkin(Image, ImageSkin);
			mapSkin(TextInput, TextInputSkin);
			mapSkin(TextArea, TextAreaSkin);
			mapSkin(ComboBox, ComboBoxSkin);
			mapSkin(Modal, ModalSkin);
			mapSkin(ButtonBarItemRender, ToggleButtonSkin);
			mapSkin(Sizer, SizerSkin);
			mapSkin(ButtonBar, ButtonBarSkin);
			mapSkin(Alert, AlertSkin);
			mapSkin(ProgressBar, ProgressBarSkin);
		}
	}
}