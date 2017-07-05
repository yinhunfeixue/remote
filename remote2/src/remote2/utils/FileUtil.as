package remote2.utils
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * 文件辅助类 
	 * @author xujunjie
	 * 
	 */	
	public class FileUtil
	{
		/**
		 * 获取文件夹列表，此方法不递归子目录
		 * @param path 根目录
		 * @return 根目录下的所有文件夹
		 * 
		 */		
		public static function listDirectory(path:File):Array
		{
			var result:Array = path.getDirectoryListing();
			for(var i:int = 0; i < result.length; i++)
			{
				if(!(result[i] as File).isDirectory)
				{
					result.splice(i, 1);
					i--;
				}
			}
			return result;
		}
		
		/**
		 * 获取文件列表 ，此方法不递归子目录
		 * @param path 根目录
		 * @param exten 文件扩展名
		 * @return 根目录下的所有文件
		 * 
		 */		
		public static function listFiles(path:File, exten:Array):Array
		{
			var result:Array = path.getDirectoryListing();
			for(var i:int = 0; i < result.length; i++)
			{
				var file:File = result[i] as File;
				if(file.isDirectory || exten.indexOf(file.extension) == -1)
				{
					result.splice(i, 1);
					i--;
				}
			}
			return result;
		}
		
		/**
		 * 使用UTF字符串读取文件 
		 * @param file 文件
		 * @return 读取的字符串
		 * 
		 */		
		public static function readString(file:File):String
		{
			if(file.exists)
			{
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				var result:String = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				return result;
			}
			return "";
		}
		
		/**
		 * 把文件读到二进制流中，若文件不存在,返回null
		 * @param file 要读的文件
		 * @return 二进制流
		 * 
		 */		
		public static function readByteArray(file:File):ByteArray
		{
			if(file.exists)
			{
				var result:ByteArray = new ByteArray();
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				stream.readBytes(result, 0);
				stream.close();
				return result;
			}
			return null;
		}
		
		/**
		 * 使用UTF字符串写入文件 
		 * @param file 文件
		 * @param content 要写入的内容
		 * @param isAppend 是否追加，若为true,新内容追加到原内容后面；若为false，使用新内容替换原内容
		 * 
		 */		
		public static function writeString(file:File, content:String, isAppend:Boolean = false):void
		{
			var stream:FileStream = new FileStream();
			file.parent.createDirectory();
			stream.open(file, isAppend?FileMode.APPEND:FileMode.WRITE);
			stream.writeUTFBytes(content);
			stream.close();
		}
		
		/**
		 * 写入二进制流 
		 * @param file
		 * @param data
		 * @param isAppend
		 * 
		 */		
		public static function writeByteArray(file:File, data:ByteArray, isAppend:Boolean = false):void
		{
			var stream:FileStream = new FileStream();
			file.parent.createDirectory();
			stream.open(file, isAppend?FileMode.APPEND:FileMode.WRITE);
			stream.writeBytes(data);
			stream.close();
		}
		
		/**
		 * 移动文件，新路径不存在，会自动创建
		 * @param file 原文件
		 * @param newLocation 新位置
		 * @return 移动后的文件
		 * 
		 */		
		public static function moveFile(file:File, newLocation:File):File
		{
			if(!newLocation.parent.exists)
			{
				newLocation.parent.createDirectory();
			}
			file.moveTo(newLocation);
			return newLocation;
		}
		
		/**
		 * 通过打开对话框的方式保存文件
		 * @param browseFile 初始路径
		 * @param data 文件内容
		 * @param extension 默认后缀
		 * @param completeFunction 参数最终保存的文件路径
		 * 
		 */		
		public static function createFileWithBrowse(browseFile:File, data:ByteArray, extension:String, completeFunction:Function = null):void
		{
			EventUtil.addOnceEventListener(browseFile, Event.SELECT, browseFile_selectHandler);
			browseFile.browseForSave("");
			
			function browseFile_selectHandler(event:Event):void
			{
				var saveFile:File = event.currentTarget as File;
				if(saveFile.extension != extension)
					saveFile.nativePath += extension;
				writeByteArray(saveFile, data);
				
				if(completeFunction != null)
					completeFunction(saveFile);
			}
		}
		
	}
}