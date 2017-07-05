package test
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-5-17
	 *
	 * */
	public class PersonModel extends EventDispatcher
	{
		private var _personArr:Array = new Array();
		
		public var maxId:int = 0;
		public function PersonModel()
		{
		}
		
		public function flush():void
		{
			var so:SharedObject = SharedObject.getLocal("remote");
			so.data["user"] = _personArr;
			so.flush();
		}
		
		public function read():void
		{
			var so:SharedObject = SharedObject.getLocal("remote");
			var arr:Array = so.data["user"];
			if(arr == null)
				return;
			for (var i:int = 0; i < arr.length; i++) 
			{
				var item:PersonData = new PersonData();
				item.fill(arr[i]);
				add(item);
			}
		}
		
		public function add(value:PersonData):void
		{
			var person:PersonData = getPerson(value.id);
			if(person == null)
			{
				_personArr.push(value);
				if(value.id > maxId)
					maxId = value.id;
			}
			else
				person.fill(value);
			dispatchEvent(new Event(Event.CHANGE));
			flush();
		}
		
		public function getPerson(id:int):PersonData
		{
			var index:int = getIndex(id);
			if(index >= 0)
				return _personArr[index];
			return null;
		}
		
		private function getIndex(id:int):int
		{
			for (var i:int = 0; i < _personArr.length; i++) 
			{
				if(_personArr[i].id == id)
					return i;
			}
			return -1;
		}
		
		public function search(name:String):Vector.<PersonData>
		{
			return null;
		}
		
		public function removePerson(id:int):PersonData
		{
			var index:int = getIndex(id);
			if(index >= 0)
			{
				var result:PersonData = _personArr[index];
				_personArr.splice(index, 1);
				dispatchEvent(new Event(Event.CHANGE));
				flush();
				return result;
			}
			return null;
		}

		public function get personArr():Array
		{
			return _personArr;
		}
		
		
	}
}