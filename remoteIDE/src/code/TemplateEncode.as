package code
{
	import flash.filesystem.File;
	
	import remote2.utils.DateUtil;
	import remote2.utils.FileUtil;
	
	/**
	 * 模板到代码转换器
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class TemplateEncode
	{
		/**
		 * 变量名称
		 */		
		public static const NAME:String = "{$name}";
		/**
		 * 父容器名称
		 */
		public static const PARENTNAME:String = "{$parentName}";
		/**
		 * 变量值
		 */
		public static const VALUE:String = "{$value}";
		/**
		 * 导入所有引用
		 */
		public static const IMPORTS:String = "{$imports}";
		
		/**
		 * 父类型 
		 */		
		public static const SUPER_TYPE:String = "{$superType}";
		
		/**
		 * 构造函数初始化 
		 */		
		public static const CONSTRUCTOR:String = "{$constructor}";
		
		/**
		 * 作者
		 */
		public static const AUTHOR:String = "{$author}";
		/**
		 * 当前日期
		 */
		public static const DATE:String = "{$date}";
		/**
		 * 声明所有变量
		 */
		public static const VARIABLES:String = "{$variables}";
		/**
		 * 创建所有变量
		 */
		public static const CREATE_VARIABLES:String = "{$createVariables}";
		/**
		 * 路径，一般在导入引用时使用
		 */
		public static const PATH:String = "{$path}";
		/**
		 * 类型，一般是类名
		 */
		public static const TYPE:String = "{$type}";
		
		/**
		 * 一个属性
		 */		
		public static const ATTRIBUTE:String = "{$attribute}";
		
		/**
		 * 属性列表  
		 */		
		public static const ATTRIBUTE_LIST:String = "{$attributeList}";
		
		private var _templateType:String;
		
		private var _addTemplate:String;
		private var _attributeTemplate:String;
		private var _classTemplate:String;
		private var _importTemplate:String;
		private var _variableTemplate:String;
		private var _variableCreateTemplate:String;
		
		public function TemplateEncode(templateType:String):void
		{
			_templateType = templateType;
			readTemplates();
		}
		
		public function encodeAdd(parentName:String, childName:String):String
		{
			var result:String = _addTemplate;
			result = result.replace(toReg(PARENTNAME), parentName);
			result = result.replace(toReg(NAME), childName);
			return result;
		}
		
		/**
		 * 编码属性 
		 * @param name 对象名
		 * @param attribute 属性名
		 * @param value 属性值
		 * @return 
		 * 
		 */		
		public function encodeAttribute(name:String, attribute:String, value:*, decodeString:Boolean = true):String
		{
			var result:String = _attributeTemplate;
			result = result.replace(toReg(NAME), name);
			result = result.replace(toReg(ATTRIBUTE), attribute);
			if(value is String && decodeString)
				result = result.replace(toReg(VALUE), '"' + value + '"');
			else
				result = result.replace(toReg(VALUE), value);
			return result;
		}
		
		public function encodeClass(imports:String, classType:String, variables:String, createVariables:String, 
									superType:String, constructor:String,
									author:String = "", date:Date = null):String
		{
			var result:String = _classTemplate;
			result = result.replace(toReg(IMPORTS), imports);
			result = result.replace(toReg(TYPE), classType);
			result = result.replace(toReg(VARIABLES), variables);
			result = result.replace(toReg(SUPER_TYPE), superType);
			result = result.replace(toReg(CONSTRUCTOR), constructor);
			result = result.replace(toReg(CREATE_VARIABLES), createVariables);
			result = result.replace(toReg(AUTHOR), author);
			
			if(date == null)
				date = new Date();
			result = result.replace(toReg(DATE), DateUtil.format(date));
			return result;
		}
		
		public function encodeImport(path:String):String
		{
			var result:String = _importTemplate;
			return result.replace(toReg(PATH), path);
		}
		
		public function encodeVariable(name:String, type:String):String
		{
			var result:String  =_variableTemplate;
			result = result.replace(toReg(NAME), name);
			result = result.replace(toReg(TYPE), type);
			return result;
		}
		
		/**
		 * 创建变量 
		 * @param name 变量标识
		 * @param type 类型
		 * @param attributeList 属性列表字符串
		 * @return 变量创建字符串
		 * 
		 */		
		public function encodeVariableCreate(name:String, type:String, attributeList:String):String
		{
			var result:String  =_variableCreateTemplate;
			result = result.replace(toReg(NAME), name);
			result = result.replace(toReg(TYPE), type);
			result = result.replace(toReg(ATTRIBUTE_LIST), attributeList);
			return result;
		}
		
		private function toReg(str:String, option:* = "g"):RegExp
		{
			return new RegExp(str.replace(/([\{\}\$]{1})/g, "\\$1"), option);
		}
		
		private function readTemplates():void
		{
			var path:String = File.applicationDirectory.nativePath + "/code/templates/" + _templateType + "/";
			_addTemplate = FileUtil.readString(new File(path + "add.template"));
			_attributeTemplate = FileUtil.readString(new File(path + "attribute.template"));
			_classTemplate = FileUtil.readString(new File(path + "class.template"));
			_importTemplate = FileUtil.readString(new File(path + "import.template"));
			_variableTemplate = FileUtil.readString(new File(path + "variable.template"));
			_variableCreateTemplate = FileUtil.readString(new File(path + "variableCreate.template"));
			
			var reg:RegExp = /\\r/g;
			_addTemplate = _addTemplate.replace(reg, "\r\n");
			_attributeTemplate = _attributeTemplate.replace(reg, "\r\n");
			_classTemplate = _classTemplate.replace(reg, "\r\n");
			_importTemplate = _importTemplate.replace(reg, "\r\n");
			_variableTemplate = _variableTemplate.replace(reg, "\r\n");
			_variableCreateTemplate = _variableCreateTemplate.replace(reg, "\r\n");
			
		}
	}
}