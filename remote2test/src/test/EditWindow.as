package test
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import remote2.collections.ArrayCollection;
	import remote2.components.Button;
	import remote2.components.CheckBox;
	import remote2.components.ComboBox;
	import remote2.components.Group;
	import remote2.components.Label;
	import remote2.components.List;
	import remote2.components.TextArea;
	import remote2.components.TextInput;
	import remote2.components.TitleWindow;
	import remote2.events.CloseEvent;
	import remote2.events.RemoteEvent;
	import remote2.layouts.HorizontalLayout;
	import remote2.manager.PopUpManager;
	
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-6
	 */	
	public class EditWindow extends TitleWindow
	{
		protected var btnAdd:Button;
		protected var tbName:TextInput;
		protected var tbNumber:TextInput;
		protected var tbEmail:TextInput;
		protected var tbDes:TextArea;
		protected var comboBoxAge:ComboBox;
		protected var cbSex:CheckBox;
		protected var listHeadImage:List;
		
		private var _settinData:PersonData;
		private var _settinDataChanged:Boolean;
		
		public function EditWindow()
		{
			super();
			title = "信息录入";
			
			addEventListener(CloseEvent.CLOSE, closeHandler);
			addEventListener(RemoteEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function creationCompleteHandler(event:Event):void
		{
			PopUpManager.centerPopUp(this);
		}
		
		protected function closeHandler(event:Event):void
		{
			PopUpManager.removePopUp(this);
		}
		
		override protected function onSkinAdded():void
		{
			super.onSkinAdded();
			
			var lbName:Label = new Label();
			lbName.text = "姓名：";
			lbName.top = 20;
			lbName.left = 50;
			addContent(lbName);
			
			tbName = new TextInput();
			tbName.width = 150;
			tbName.prompt = "输入姓名";
			tbName.left = 100;
			tbName.top = 20;
			tbName.color = 0xff5533;
			addContent(tbName);
			
			cbSex = new CheckBox();
			cbSex.label = "男";
			cbSex.top = 20;
			cbSex.left = 270;
			addContent(cbSex);
			
			var lbPassword:Label = new Label();
			lbPassword.top = 50;
			lbPassword.left = 50;
			lbPassword.text = "手机：";
			addContent(lbPassword);
			
			tbNumber = new TextInput();
			tbNumber.prompt = "输入手机号码";
			tbNumber.restrict = "0-9";
			tbNumber.width = 150;
			tbNumber.left = 100;
			tbNumber.top = 50;
			addContent(tbNumber);
			
			var lbEmail:Label = new Label();
			lbEmail.text = "email：";
			lbEmail.top =80;
			lbEmail.left = 50;
			addContent(lbEmail);
			
			tbEmail = new TextInput();
			tbEmail.prompt = "email";
			tbEmail.restrict = "0-9a-zA-Z@.";
			tbEmail.top = 80;
			tbEmail.left = 100;
			tbEmail.width = 150;
			addContent(tbEmail);
			
			tbDes = new TextArea();
			tbDes.prompt = "你对他的印象";
			tbDes.width = 150;
			tbDes.height = 150;
			tbDes.left = 100;
			tbDes.top = 110;
			addContent(tbDes);
			
			var ageArr:Array = [];
			for(var i:int = 0; i < 90; i++)
			{
				ageArr.push(i);
			}
			
			comboBoxAge = new ComboBox();
			comboBoxAge.prompt = "选择年龄";
			comboBoxAge.labelFunction = ageLabelFunction;
			comboBoxAge.width = 100;
			comboBoxAge.height = 20;
			comboBoxAge.dataProvider = new ArrayCollection(ageArr);
			comboBoxAge.left = 100;
			comboBoxAge.top = 270;
			addContent(comboBoxAge);
			
			listHeadImage = new List();
			listHeadImage.layout = new HorizontalLayout();
			listHeadImage.itemRender = HeadItemRender;
			listHeadImage.dataProvider = new ArrayCollection([1000, 1001, 1002, 1003, 1004, 1005]);
			listHeadImage.top = 300;
			listHeadImage.left = 100;
			listHeadImage.right = 10;
			listHeadImage.styleName = "empty";
			addContent(listHeadImage);
			
			var foot:Group = new Group();
			foot.bottom = 10;
			foot.top = 370;
			foot.left = 100;
			var l:HorizontalLayout = new HorizontalLayout();
			l.gap = 20;
			foot.layout = l;
			addContent(foot);
			
			btnAdd = new Button();
			btnAdd.toolTip = btnAdd.label = "添加";
			btnAdd.addEventListener(MouseEvent.CLICK, btnLogin_clickHandler);
			foot.addChild(btnAdd);
		}
		
		private function ageLabelFunction(item:int, index:int):String
		{
			return "年龄：" + item;
		}
		
		protected function btnLogin_clickHandler(event:MouseEvent):void
		{
			var person:PersonData = new PersonData(_settinData?_settinData.id:Model.personModel.maxId + 1, tbName.text, listHeadImage.selectedItem);
			person.phoneNumber = tbNumber.text;
			person.des = tbDes.text;
			person.enabled = true;
			person.age = comboBoxAge.selectedItem as int;
			person.email = tbEmail.text;
			person.sex = cbSex.selected;
			Model.personModel.add(person);
			PopUpManager.removePopUp(this);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_settinDataChanged)
			{
				if(_settinData)
				{
					tbName.text = _settinData.name;
					tbNumber.text = _settinData.phoneNumber;
					tbEmail.text = _settinData.email;
					listHeadImage.selectedItem = _settinData.headImage;
					cbSex.selected = _settinData.sex;
					tbDes.text = _settinData.des;
					comboBoxAge.selectedItem = _settinData.age;
				}
			}
		}

		public function get settinData():PersonData
		{
			return _settinData;
		}

		public function set settinData(value:PersonData):void
		{
			_settinData = value;
			_settinDataChanged = true;
			invalidateProperties();
		}

	}
}