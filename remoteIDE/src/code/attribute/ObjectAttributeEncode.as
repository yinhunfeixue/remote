package code.attribute
{
	import code.EncodeBase;
	import code.IEncode;
	import code.TemplateEncode;
	
	/**
	 * 对象属性到代码的转换器
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class ObjectAttributeEncode extends EncodeBase implements IEncode
	{
		private var _attEncoders:Vector.<IEncode> = new Vector.<IEncode>();

		public function ObjectAttributeEncode(template:TemplateEncode, decodeString:Boolean)
		{
			super(template);
			
			_attEncoders.push(new PositionEncode(template, decodeString), new SizeEncode(template, decodeString), 
				new LayoutEncode(template, decodeString), new BaseTextFormatEncode(template, decodeString), new StyleEncode(template, decodeString));
		}
		
		public function encode(target:Object):String
		{
			var result:String = "";
			
			for (var i:int = 0; i < _attEncoders.length; i++) 
			{
				result += _attEncoders[i].encode(target);
			}
			return result;
		}
		
	}
}