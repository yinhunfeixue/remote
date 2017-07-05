package remote2.utils
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	public class ObjectUtil2
	{
		/**
		 * 深拷贝一个对象 
		 * @param o 拷贝的数据源
		 * @return 拷贝后的对象
		 * 
		 */		
		public static function clone(o:Object):Object
		{
			if(o != null)
			{
				var byteArr:ByteArray=new ByteArray();
				byteArr.writeObject(o);
				byteArr.position=0;
				return byteArr.readObject();
			}
			return null;
		}
		
		/**
		 *  把对象写入二进制数组 
		 * @param o
		 * @return 
		 * 
		 */		
		public static function writeToByteArrar(o:Object):ByteArray
		{
			if(o != null)
			{
				var result:ByteArray=new ByteArray();
				result.writeObject(o);
				result.position=0;
				return result;
			}
			return null;
		}
		
		/**
		 * 填充对象，把source对象的数据填充到to对象
		 * @param source 填充源
		 * @param to 要填充的对象，将把source中的数据填充到此参数的对象中
		 * @param strictMode 是否严格模式，非严格模式下，to对象可能被添加原本不存在的属性
		 * @return 在to参数中传递的对象
		 * 
		 */		
		public static function fill(source:Object, to:Object, strictMode:Boolean = true):Object
		{
			var name:String=flash.utils.getQualifiedClassName(source);
			var o:Object;
			if(name!="Object")
				o=clone(source);
			else 
				o=source;
			
			for(var key:* in o)
			{
				if(strictMode)
				{
					if(to.hasOwnProperty(key))
						to[key] = o[key];
				}
				else
					to[key] = o[key];
			}
			
			return to;
		}
		
		/**
		 * 判断一个对象是否有属性 
		 * @param o 对象
		 * @return 是否有属性
		 * 
		 */		
		public static function isEmpty(o:Object):Boolean
		{
			for(var key:* in o)
			{
				return true;
			}
			return false;
		}
	}
}