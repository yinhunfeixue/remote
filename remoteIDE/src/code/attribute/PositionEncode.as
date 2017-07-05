package code.attribute
{
	import code.AttributeData;
	import code.TemplateEncode;
	
	
	
	/**
	 * 位置相关的属性转换
	 * x
	 * y
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	internal class PositionEncode extends AttributeEncode
	{
		public function PositionEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template, decodeString);
		}
		
		override protected function createAttributes():void
		{
			attributes = new Vector.<AttributeData>();
			attributes.push(new AttributeData("x", Number, [0]));
			attributes.push(new AttributeData("y", Number, [0]));
		}

	}
}