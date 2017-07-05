package code.attribute
{
	import code.AttributeData;
	import code.TemplateEncode;
	
	
	/**
	 * 布局属性编码
	 * left
	 * right
	 * top
	 * bottom
	 * horizontalCenter
	 * verticalCenter
	 * includeInLayout
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	internal class LayoutEncode extends AttributeEncode
	{
		public function LayoutEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template, decodeString);
		}
		
		override protected function createAttributes():void
		{
			attributes = new Vector.<AttributeData>();
			attributes.push(new AttributeData("left", Number, [0]));
			attributes.push(new AttributeData("right", Number, [0]));
			attributes.push(new AttributeData("top", Number, [0]));
			attributes.push(new AttributeData("bottom", Number, [0]));
			attributes.push(new AttributeData("horizontalCenter", Number, [0]));
			attributes.push(new AttributeData("verticalCenter", Number, [0]));
			attributes.push(new AttributeData("includeInLayout", Boolean, [true]));
			
		}
		
	}
}