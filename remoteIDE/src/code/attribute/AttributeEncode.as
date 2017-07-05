package code.attribute
{
	import code.AttributeData;
	import code.EncodeBase;
	import code.IEncode;
	import code.TemplateEncode;
	
	/**
	 * 属性编码基类
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	internal class AttributeEncode extends EncodeBase implements IEncode
	{
	
		protected var attributes:Vector.<AttributeData>;
		protected var decodeString:Boolean;
		
		public function AttributeEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template);
			this.decodeString = decodeString;
			createAttributes();
		}
		
		/**
		 * 创建要编码的属性，需要重写
		 * 
		 */		
		protected function createAttributes():void
		{
			
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		public function encode(target:Object):String
		{
			if(attributes == null)
				return "";
			var result:String = "";
			for (var i:int = 0; i < attributes.length; i++) 
			{
				if(attributeIsEffect(target, attributes[i]))
					result += template.encodeAttribute(target.name, attributes[i].name, target[attributes[i].name], decodeString);
			}
			return result;
		}
		
		/**
		 * 属性是否有效 
		 * @param object
		 * @param attribute
		 * @return 
		 * 
		 */		
		private function attributeIsEffect(object:Object, attribute:AttributeData):Boolean
		{
			if(object.hasOwnProperty(attribute.name))			//如果有此属性，进行其它判断，否则直接为false;
			{
				if(attribute.defaultValues == null || attribute.defaultValues.length == 0)			//若无默认值，则任何值都是有效的，需要生成的
					return true;
				else
				{
					if(attribute.type == Number && isNaN(object[attribute.name]))					//Number需要特别判断，因为NaN不等于NaN
						return false;
					return attribute.defaultValues.indexOf(object[attribute.name]) < 0;				//若值不是默认值中的一个，则是有效的
				}
			}
			return false;
		}
	}
}