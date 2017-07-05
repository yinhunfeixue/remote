package code.attribute
{
	import code.AttributeData;
	import code.TemplateEncode;
	
	/**
	 * 
	 *
	 * @author xujunjie
	 * @date 2013-5-29 下午10:34:17
	 * 
	 */	
	public class SizeEncode extends AttributeEncode
	{
		public function SizeEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template, decodeString);
		}
		
		override protected function createAttributes():void
		{
			attributes = new Vector.<AttributeData>();
			attributes.push(new AttributeData("percentWidth", Number, [0]));
			attributes.push(new AttributeData("percentHeight", Number, [0]));
			attributes.push(new AttributeData("width", Number, [0]));
			attributes.push(new AttributeData("height", Number, [0]));
		}
	}
}