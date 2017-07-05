package code.actionscriptXML
{
	import code.EncodeBase;
	import code.IEncode;
	import code.TemplateEncode;
	import code.attribute.ObjectAttributeEncode;
	
	import configs.init.Init;
	
	import flash.utils.Dictionary;
	
	import remote2.components.UIComponent;
	import remote2.utils.ClassUtil;
	
	import modules.canvas.Holder;
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-9
	 *
	 * */
	public class ObjectEncode extends EncodeBase implements IEncode
	{
		private var _attributeEncode:ObjectAttributeEncode;
		private var _className:String;
		
		/**
		 * 
		 * @param template 代码模板 
		 * @param className 类名
		 * 
		 */
		public function ObjectEncode(template:TemplateEncode, className:String)
		{
			super(template);
			_className = className;
			
			_attributeEncode = new ObjectAttributeEncode(template, false);
		}
		
		public function encode(target:Object):String
		{
			var dicSelf:Dictionary = encodeSelf(target);
			var dicChildren:Dictionary = encodeChildren(target as UIComponent);
			//去除重复的import
			var arrayImport:Array = (dicChildren[IMPORT] as Array).concat(dicSelf[IMPORT]);
			arrayImport.sort();
			var i:int;
			for(i = 0; i < arrayImport.length - 1; i++)
			{
				if(arrayImport[i + 1] == arrayImport[i])
				{
					arrayImport.splice(i, 1);
					i--;
				}
			}
			//把子对象XML，转换成字符串
			var arrayChildren:Array = dicChildren[VARIABLES_CREATE];
			if(arrayChildren)
			{
				for(i = 0; i < arrayChildren.length; i++)
				{
					arrayChildren[i] = (arrayChildren[i] as XML).toXMLString();
				}
			}
			XML.ignoreComments = false;
			return new XML(template.encodeClass(arrayImport.join(""), _className, "", arrayChildren.join("\r\n"), dicSelf[SUPERTYPE], dicSelf[CONSTRUCTOR],
			Init.userName)).toXMLString();
		}
		
		private function encodeSelf(target:Object):Dictionary
		{
			var packageType:String = ClassUtil.getPackageString(target);
			var classType:String = ClassUtil.getClassString(target);
			
			var result:Dictionary = new Dictionary();
			result[SUPERTYPE] = classType;
			result[IMPORT] = template.encodeImport(packageType);
			result[CONSTRUCTOR] = _attributeEncode.encode(target);
			return result;
		}
		
		
		/**
		 * 对子对象编码，生成键值对，包含 IMPORT、VARIABLES_CREATE三部分
		 * @param target
		 * @return 
		 * 
		 */		
		private function encodeChildren(target:UIComponent):Dictionary
		{
			var arrayImport:Array = [], arrayChild:Array = [];
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var holder:Holder = target.getChildAt(i) as Holder;			//取出holder，所有手动添加的子组件，都会在外面包一个holder，用于识别
				if(holder)
				{
					var child:UIComponent = holder.component;
					//获取类型
					var packageType:String = ClassUtil.getPackageString(child);
					var classType:String = ClassUtil.getClassString(child);
					//添加import
					var currentImport:String = template.encodeImport(packageType);
					if(arrayImport.indexOf(currentImport) == -1)
						arrayImport.push(currentImport);
					//添加variablesCreate
					var currentXml:XML = new XML(template.encodeVariableCreate(child.name, classType,_attributeEncode.encode(child)));			//先生成创建代码
					arrayChild.push(currentXml);
					//递归子对象
					var childDic:Dictionary = encodeChildren(child);
					
					//子对象添加到
					arrayImport = arrayImport.concat(childDic[IMPORT]);
					if(childDic[VARIABLES_CREATE])
					{
						var arr:Array = childDic[VARIABLES_CREATE];
						for(var ii:int = 0; i < arr.length; i++)
							currentXml.appendChild(arr[i]);
					}
				}
				
			}
			var result:Dictionary = new Dictionary();
			result[IMPORT] = arrayImport;
			result[VARIABLES_CREATE] = arrayChild;
			return result;
		}
	}
}