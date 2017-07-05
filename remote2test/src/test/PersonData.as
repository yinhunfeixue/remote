package test
{
	
	/**
	 * 
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-9
	 */	
	public class PersonData
	{
		public var id:int;
		public var name:String;
		public var phoneNumber:String;
		public var email:String
		public var headImage:int;
		public var sex:Boolean;
		public var des:String;
		public var age:int;
		public var enabled:Boolean = true;
		
		public function PersonData(id:int = -1, name:String = null, type:int = -1)
		{
			this.id = id;
			this.name = name;
			this.headImage = type;
		}
		
		public function fill(data:Object):void
		{
			id = data.id;
			name = data.name;
			sex = data.sex;
			headImage = data.headImage;
			phoneNumber = data.phoneNumber;
			email = data.email;
			des = data.des;
			age = data.age;
			enabled = data.enabled;
		}
	}
}