package code.attribute
{
	import code.AttributeData;
	import code.TemplateEncode;
	
	
	
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	internal class BaseTextFormatEncode extends AttributeEncode
	{
		public function BaseTextFormatEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template, decodeString);
		}
		
		override protected function createAttributes():void
		{
			attributes = new Vector.<AttributeData>();
			attributes.push(new AttributeData("color", uint, [0x00000]));
			attributes.push(new AttributeData("fontFamily", String, [null, ""]));
			attributes.push(new AttributeData("bold", Boolean, [false]));
			attributes.push(new AttributeData("italic", Boolean, [false]));
			attributes.push(new AttributeData("fontSize", Number, [12, 0]));
			//attributes.push(new AttributeData("align", String, [TextAlign.LEFT, null, ""]));
			attributes.push(new AttributeData("underline", Boolean, [false]));
		
		}
	}
}