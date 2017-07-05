package modules.project.vo
{
	import flash.filesystem.File;
	
	/**
	 *
	 *
	 * @author yinhunfeixue
	 * @date 2013-6-19
	 *
	 * */
	public class ProjectData
	{
		/**
		 * 项目根路径 
		 */		 
		public var path:File;
		
		/**
		 * 主题库,swf文件路径 
		 */		
		public var theme:File;
		
		/**
		 * 实例化 
		 * @param path 项目根目录
		 * @param theme 主题文件
		 * 
		 */		
		public function ProjectData(path:File, theme:File)
		{
			this.path = path;
			this.theme = theme;
		}
	}
}