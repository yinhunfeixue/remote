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
	internal class StyleEncode extends AttributeEncode
	{
		public function StyleEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template, decodeString);
		}
		
		override protected function createAttributes():void
		{
			attributes = new Vector.<AttributeData>();
			attributes.push(new AttributeData("styleName", String, [null, ""]));
		}
	}
}