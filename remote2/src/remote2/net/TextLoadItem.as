package remote2.net
{
	import flash.net.URLLoaderDataFormat;

	public class TextLoadItem extends URLLoaderItem
	{
		public function TextLoadItem()
		{
			super();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		}
	}
}