package test
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import remote2.components.Button;
	import remote2.components.Group;
	import remote2.components.Image;
	import remote2.components.Label;
	import remote2.components.ToggleButton;
	import remote2.components.supports.ItemRenderBase;
	import remote2.core.DragControl;
	import remote2.core.DragSource;
	import remote2.core.IItemRender;
	import remote2.core.Injector;
	import remote2.core.RemoteGlobals;
	import remote2.events.DragEvent;
	import remote2.events.ResizeEvent;
	import remote2.graphics.ImageScaleMode;
	import remote2.manager.DragManager;
	import remote2.manager.IDragManager;
	import remote2.manager.PopUpManager;
	import remote2.manager.dragClasses.DragManagerImpl;
	import remote2.skins.remoteSkins.TitleWindowCloseButtonSkin;
	
	import test.skin.SwitchButtonSkin;
	
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-9
	 */	
	public class PersonItemRender extends ItemRenderBase implements IItemRender
	{
		protected var labelName:Label;
		protected var labelPhoneNumber:Label;
		protected var labelEmail:Label;
		protected var headImage:Image;
		
		private var _dataChanged:Boolean;
		
		protected var buttonEnable:ToggleButton;
		protected var buttonEdit:Button;
		protected var buttonDelete:Button;
		protected var controlGroup:Group;
		
		protected var dragControl:DragControl;
		
		public function PersonItemRender()
		{
			super();
			mouseChildren = true;
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
		
		private function get personData():PersonData
		{
			return data;
		}
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataChanged)
			{
				_dataChanged = false;
				if(personData)
				{
					labelName.text = personData.name + " " + personData.age + "岁" + "(" + (personData.sex?"♂":"♀") + ")";
					labelPhoneNumber.text = personData.phoneNumber;
					labelEmail.text = personData.email;
					headImage.source = "../assets/" + personData.headImage + ".png";
					headImage.toolTip = personData.des;
					buttonDelete.enabled = buttonEdit.enabled = personData.enabled;
					buttonEnable.selected = personData.enabled;
					alpha = personData.enabled?1:0.4;
				}
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelName = new Label();
			labelName.top = 5;
			addChild(labelName);
			
			labelPhoneNumber = new Label();
			labelPhoneNumber.top = 25;
			addChild(labelPhoneNumber);
			
			labelEmail = new Label();
			labelEmail.top = 45;
			addChild(labelEmail);
			
			labelName.left = labelPhoneNumber.left = labelEmail.left = 72;
			
			headImage = new Image();
			headImage.scaleMode = ImageScaleMode.LETTERBOX;
			headImage.top = headImage.bottom = 5;
			headImage.x = 5;
			headImage.addEventListener(DragEvent.DRAG_START, headImage_dragStartHandler);
			headImage.addEventListener(DragEvent.DRAG_ENTER, headImage_dragEnterHandler);
			headImage.addEventListener(DragEvent.DRAG_DROP, headImage_dragDropHandler);
			addChild(headImage);
			
			controlGroup = new Group();
			controlGroup.percentHeight = 100;
			controlGroup.percentWidth = 100;
			addChild(controlGroup);
			
			buttonEdit = new Button();
			buttonEdit.left = 72;
			buttonEdit.top = 80;
			buttonEdit.bottom = 5;
			buttonEdit.label = "编辑";
			buttonEdit.addEventListener(MouseEvent.CLICK, buttonEdit_clickHandler);
			controlGroup.addChild(buttonEdit);
			
			buttonEnable = new ToggleButton();
			buttonEnable.top = 65;
			buttonEnable.left = 72;
			buttonEnable.styleName = "switchButton";
			buttonEnable.width = 30;
			buttonEnable.height = 10;
			buttonEnable.addEventListener(Event.CHANGE, buttonEnable_changedHandler);
			controlGroup.addChild(buttonEnable);
			
			buttonDelete = new Button();
			buttonDelete.skinClass = TitleWindowCloseButtonSkin;
			buttonDelete.width = 15;
			buttonDelete.height = 15;
			buttonDelete.bottom = 5;
			buttonDelete.left = 120;
			buttonDelete.addEventListener(MouseEvent.CLICK, buttonDelete_clickHandler);
			controlGroup.addChild(buttonDelete);
			
			dragControl = new DragControl(headImage);
			dragControl.allowDrag();
			
		}
		
		protected function headImage_dragDropHandler(event:DragEvent):void
		{
			personData.headImage = event.dragSource.dataForFormat("headImage") as int;
			Model.personModel.add(personData);
		}
		
		protected function headImage_dragEnterHandler(event:DragEvent):void
		{
			if(event.dragSource.hasFormat("headImage"))
				DragManager.acceptDragDrop(headImage);
			
		}
		
		protected function headImage_dragStartHandler(event:DragEvent):void
		{
			var source:DragSource = new DragSource();
			source.addData(personData.headImage, "headImage");
			DragManager.doDrag(headImage, source, event, null, -event.localX, -event.localY);
		}
		
		protected function buttonDelete_clickHandler(event:MouseEvent):void
		{
			Model.personModel.removePerson(personData.id);
		}
		
		protected function buttonEnable_changedHandler(event:Event):void
		{
			if(personData)
			{
				personData.enabled = buttonEnable.selected;
				Model.personModel.add(personData);
			}
		}
		
		protected function buttonEdit_clickHandler(event:MouseEvent):void
		{
			var window:EditWindow = new EditWindow();
			window.settinData = personData;
			PopUpManager.addPopUp(window, true);
		}
		
		override public function set data(value:*):void
		{
			super.data = value;
			_dataChanged = true;
			invalidateProperties();
		}
	}
}