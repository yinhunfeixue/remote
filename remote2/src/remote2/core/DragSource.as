package remote2.core
{
	import flash.utils.Dictionary;

	/**
	 * DragSource 类中包含正被拖动的数据。数据可以采用多种格式，具体取决于启动拖动的控件的类型。<br/>
	 * 每种数据格式都使用一个字符串进行标识。hasFormat() 方法用于确定对象是否包含使用相应格式的数据。dataForFormat() 方法用于检索指定格式的数据。<br/>
	 * 可以使用 addData() 方法直接
	 *
	 * @author xujunjie
	 * @date 2013-5-27 下午9:21:09
	 * 
	 */	
	public class DragSource
	{
		private var dataHolder:Dictionary = new Dictionary();	
		private var formatHandlers:Dictionary = new Dictionary();
		
		/**
		 * 实例化 
		 * 
		 */		
		public function DragSource()
		{
		}
		
		/**
		 * 添加数据 
		 * @param data 指定拖动数据的对象。
		 * @param format 字符串，用于指定一个标签来描述此数据格式。
		 * 
		 */		
		public function addData(data:Object, format:String):void
		{
			dataHolder[format] = data;
		}
		
		/**
		 * 检索指定格式的数据。如果此数据是使用 addData() 方法添加的，则可以直接返回此数据。
		 * @param format 字符串，用于指定一个标签来描述要返回的数据的格式。需要addData中添加过，否则返回NULL
		 * @return 包含所请求格式的数据的 Object
		 * 
		 */		
		public function dataForFormat(format:String):Object
		{
			if(dataHolder[format])
				return dataHolder[format];
			return null;
		}
		
		/**
		 * 数据源是否包含指定的格式 
		 * @param format 描述数据格式的标签
		 * @return 数据
		 * 
		 */		
		public function hasFormat(format:String):Boolean
		{
			return dataHolder[format] != null;
		}
	}
}