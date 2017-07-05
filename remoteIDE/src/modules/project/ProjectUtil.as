package modules.project
{
	import configs.ExtensionConfig;
	
	import flash.filesystem.File;
	
	import mx.utils.StringUtil;
	
	import modules.project.vo.ProjectData;
	
	import remote2.utils.FileUtil;
	import remote2.utils.PathUtil;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-19
	 *
	 * */
	public class ProjectUtil
	{
		
		public static function save(path:File, data:ProjectData):void
		{
			var xml:XML = new XML("<root/>");
			xml.appendChild(new XML(StringUtil.substitute("<path>{0}</path>", data.path.nativePath)));
			xml.appendChild(new XML(StringUtil.substitute("<theme>{0}</theme>", data.theme.nativePath)));
			var extension:String = PathUtil.getExtension(path.nativePath);
			if(extension != ExtensionConfig.PROJECT)
			{
				path = new File(PathUtil.getPath(path.nativePath) + PathUtil.getFileNameWithoutExtension(path.nativePath) + ExtensionConfig.PROJECT);
			}
			FileUtil.writeString(path, xml.toXMLString());
		}
		
		public static function read(path:File):ProjectData
		{
			var xml:XML = new XML(FileUtil.readString(path));
			var result:ProjectData = new ProjectData(new File(xml.path), new File(xml.theme));
			return result;
		}
	}
}