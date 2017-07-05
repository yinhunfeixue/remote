package code.actionscript
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
	 * @date 2013-5-29
	 *
	 * */
	public class ObjectEncode extends EncodeBase implements IEncode
	{
		private var _attributeEncode:ObjectAttributeEncode;
		private var _className:String;
		public function ObjectEncode(template:TemplateEncode, className:String)
		{
			super(template);
			
			_className = className;
			_attributeEncode = new ObjectAttributeEncode(template, true);
		}
		
		/**
		 * 要编码的对象
		 * @param target
		 * @return 
		 * 
		 */		
		public function encode(target:Object):String
		{
			target.name = "this";
			var childInfo:Dictionary = encodeChildren(target as UIComponent);
			var selfInfo:Dictionary = encodeSelf(target);
			
			//去除重复的import
			var arrayImport:Array = (childInfo[IMPORT] as Array).concat(selfInfo[IMPORT]);
			arrayImport.sort();
			for(var i:int = 0; i < arrayImport.length - 1; i++)
			{
				if(arrayImport[i + 1] == arrayImport[i])
				{
					arrayImport.splice(i, 1);
					i--;
				}
			}
			
			var result:String = template.encodeClass(arrayImport.join(""), _className, childInfo[VARIABLES], childInfo[VARIABLES_CREATE], 
				selfInfo[SUPERTYPE], selfInfo[CONSTRUCTOR], Init.userName);
			return result;
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
		 * 对子对象编码，生成键值对，包含 IMPORT、VARIABLES、VARIABLES_CREATE三部分
		 * @param target
		 * @return 
		 * 
		 */		
		private function encodeChildren(target:UIComponent):Dictionary
		{
			var arrayImport:Array = [], strVariables:String = "", strVariablesCreate:String = "";
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
					//添加variables
					strVariables += template.encodeVariable(child.name, classType);
					//添加variablesCreate
					strVariablesCreate += template.encodeVariableCreate(child.name, classType, _attributeEncode.encode(child));			//先生成创建代码
					//添加到父容器中
					strVariablesCreate += template.encodeAdd(target.name, child.name);
					
					//递归子对象
					var childDic:Dictionary = encodeChildren(child);
					
					arrayImport = arrayImport.concat(childDic[IMPORT]);
					strVariables += childDic[VARIABLES];
					strVariablesCreate += childDic[VARIABLES_CREATE];
				}
			}
			var result:Dictionary = new Dictionary();
			result[IMPORT] = arrayImport;
			result[VARIABLES] = strVariables;
			result[VARIABLES_CREATE] = strVariablesCreate;
			return result;
		}
	}
}