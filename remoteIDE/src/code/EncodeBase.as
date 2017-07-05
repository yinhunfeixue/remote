package code
{
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-29
	 *
	 * */
	public class EncodeBase
	{
		protected const IMPORT:String = "import";
		protected const VARIABLES:String = "variables";
		protected const VARIABLES_CREATE:String = "variablesCreate";
		protected const CONSTRUCTOR:String = "constructor";
		protected const SUPERTYPE:String = "superType";
			
		protected var template:TemplateEncode;
		public function EncodeBase(template:TemplateEncode)
		{
			this.template = template;
		}
	}
}