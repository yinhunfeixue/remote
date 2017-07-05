package modules.project.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import modules.project.ProjectUtil;
	import modules.project.vo.ProjectData;
	
	import remote2.components.Button;
	import remote2.components.Label;
	import remote2.components.TextInput;
	import remote2.components.TitleWindow;
	import remote2.events.CloseEvent;
	import remote2.manager.PopUpManager;
	
	/**
	 * 
	 *
	 * @author ybyt
	 * @date 2013-06-19 13:47:00
	 * 
	 */	
	public class CreateWindow extends TitleWindow
	{
		//变量声明
		protected var textInputRoot:TextInput;
		protected var buttonRoot:Button;
		protected var textInputTheme:TextInput;
		protected var buttonTheme:Button;
		protected var label0:Label;
		protected var label1:Label;
		protected var buttonSave:Button;
		
		private var _rootFolder:File;
		private var _themeFile:File;
		private var _createProject:ProjectData;			//创建的项目信息
		
		//构造函数
		public function CreateWindow()
		{
			super();
			isPopup = true;
			title = "创建项目";
			addEventListener(CloseEvent.CLOSE, closeHandler);
			
		}
		
		protected function closeHandler(event:CloseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			textInputRoot = new TextInput();
			textInputRoot.x = 78;
			textInputRoot.y = 30;
			textInputRoot.width = 245;
			textInputRoot.height = 20;
			this.addContent(textInputRoot);
			
			buttonRoot = new Button();
			buttonRoot.addEventListener(MouseEvent.CLICK, buttonRoot_clickHandler);
			buttonRoot.label = "选择";
			buttonRoot.left = 330;
			buttonRoot.y = 30;
			buttonRoot.right = 10;
			buttonRoot.width = 60;
			buttonRoot.height = 20;
			this.addContent(buttonRoot);
			
			textInputTheme = new TextInput();
			textInputTheme.x = 78;
			textInputTheme.y = 60;
			textInputTheme.width = 245;
			textInputTheme.height = 20;
			this.addContent(textInputTheme);
			
			buttonTheme = new Button();
			buttonTheme.addEventListener(MouseEvent.CLICK, buttonTheme_clickHandler);
			buttonTheme.label = "选择";
			buttonTheme.x = 330;
			buttonTheme.y = 60;
			buttonTheme.width = 60;
			buttonTheme.height = 20;
			this.addContent(buttonTheme);
			
			label0 = new Label();
			label0.text = "代码目录：";
			label0.x = 12;
			label0.y = 30;
			label0.height = 20;
			this.addContent(label0);
			
			label1 = new Label();
			label1.text = "主题文件：";
			label1.x = 12;
			label1.y = 60;
			label1.height = 20;
			this.addContent(label1);
			
			buttonSave = new Button();
			buttonSave.label = "确定";
			buttonSave.x = 245;
			buttonSave.top = 95;
			buttonSave.bottom = 10;
			buttonSave.width = 78;
			buttonSave.height = 29;
			buttonSave.addEventListener(MouseEvent.CLICK, buttonSave_clickHandler);
			this.addContent(buttonSave);
		}
		
		protected function buttonSave_clickHandler(event:MouseEvent):void
		{
			if(_rootFolder && _themeFile && _rootFolder.exists && _themeFile.exists)
			{
				var f:File = new File();
				f.addEventListener(Event.SELECT, selectHandler);
				f.addEventListener(Event.CANCEL, cancelHandler);
				f.browseForSave("保存");
				
				function selectHandler(event:Event):void
				{
					f.removeEventListener(Event.SELECT, selectHandler);
					f.removeEventListener(Event.CANCEL, cancelHandler);
					var saveFile:File = event.target as File;
					_createProject = new ProjectData(_rootFolder, _themeFile);
					ProjectUtil.save(saveFile, _createProject);

				}
				
				function cancelHandler(event:Event):void
				{
					f.removeEventListener(Event.SELECT, selectHandler);
					f.removeEventListener(Event.CANCEL, cancelHandler);
				}	
			}
		}
		
		protected function buttonTheme_clickHandler(event:MouseEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, selectHandler);
			f.addEventListener(Event.CANCEL, cancelHandler);
			f.browseForOpen("主题", [new FileFilter("主题(*.swf)", "*.swf")]);
			
			function selectHandler(event:Event):void
			{
				f.removeEventListener(Event.SELECT, selectHandler);
				f.removeEventListener(Event.CANCEL, cancelHandler);
				_themeFile = event.target as File;
				textInputTheme.text = _themeFile.nativePath;
			}
			
			function cancelHandler(event:Event):void
			{
				f.removeEventListener(Event.SELECT, selectHandler);
				f.removeEventListener(Event.CANCEL, cancelHandler);
			}	
		}
		
		protected function buttonRoot_clickHandler(event:MouseEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, selectHandler);
			f.addEventListener(Event.CANCEL, cancelHandler);
			f.browseForDirectory("代码根目录");
			
			function selectHandler(event:Event):void
			{
				f.removeEventListener(Event.SELECT, selectHandler);
				f.removeEventListener(Event.CANCEL, cancelHandler);
				_rootFolder = event.target as File;
				textInputRoot.text = _rootFolder.nativePath;
			}
			
			function cancelHandler(event:Event):void
			{
				f.removeEventListener(Event.SELECT, selectHandler);
				f.removeEventListener(Event.CANCEL, cancelHandler);
			}	
		}

		public function get createProject():ProjectData
		{
			return _createProject;
		}

	}
}