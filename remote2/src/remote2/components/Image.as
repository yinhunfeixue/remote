package remote2.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import mx.utils.NameUtil;
	
	import remote2.core.remote_internal;
	import remote2.geom.Size;
	import remote2.graphics.ImageFillMode;
	import remote2.graphics.ImageScaleMode;
	import remote2.layouts.HorizontalAlign;
	import remote2.layouts.VerticalAlign;
	
	use namespace remote_internal;
	/**
	 * 图像控件
	 * 
	 *
	 * @author 银魂飞雪
	 * @date 2013-4-29
	 */
	public class Image extends SkinnableComponent
	{
		/**
		 * 加载失败时的显示对象类
		 * 此属性为全局属性 
		 */		
		public static var ERROR_CLASS:Class = null;
		
		private var _fillMode:String = ImageFillMode.SCALE;
		
		private var _scaleMode:String = ImageScaleMode.STRETCH;
		
		private var _horizontalAlign:String = HorizontalAlign.LEFT;
		
		private var _verticalAlign:String = VerticalAlign.TOP;
		
		private var _source:*;
		
		/**
		 * 加载器，可以设置外部加载器 
		 */		
		private var _contentLoader:Loader;
		
		/**
		 * 显示对象实例，位图或者SWF 
		 */		
		private var _content:DisplayObject;
		
		/**
		 * content的原始尺寸，当sprite缩放后，width/height属性会变化，因此需要把原始尺寸保存下来 
		 */		
		private var _contentOrgSize:Size;
		
		/**
		 * 当加载或者设置的对象是位图时，表示对应的位图数据 
		 */		
		private var _bitmapData:BitmapData;
		
		/**
		 * 用于绘图的画板 
		 */		
		private var _canvas:Shape;
		
		public function Image()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_canvas = new Shape();
			$addChild(_canvas);
		}
		
		override protected function measure():void
		{
			if(_content != null)
			{
				if(!isNaN(explicitWidth) || !isNaN(explicitHeight))
				{
					switch(_fillMode)
					{
						case ImageFillMode.CLIP:
						case ImageFillMode.REPEAT:
							measuredWidth = _content.width;
							measuredHeight = _content.height;
							break;
						case ImageFillMode.SCALE:
							var scale:Number;
							if(!isNaN(explicitWidth))
							{
								scale = explicitWidth / _content.width;
								measuredWidth = explicitWidth;
								measuredHeight = _content.height * scale;
							}
							else if(!isNaN(explicitHeight))
							{
								scale = explicitHeight / _content.height;
								measuredWidth = _content.width * scale;
								measuredHeight = explicitHeight;
							}
							break;
					}
				}
				else
				{
					measuredWidth = _content.width;
					measuredHeight = _content.height;
				}
			}
			else
				super.measure();
		}
		
		override protected function updateDisplayList(unscaleWidth:Number, unscaleHeight:Number):void
		{
			super.updateDisplayList(unscaleWidth, unscaleHeight);
			var contentWidth:Number = unscaleWidth, contentHeight:Number = unscaleHeight;
			var scale:Point = new Point(1, 1), startPoint:Point;
			var drawBitmapData:BitmapData = _bitmapData;
			var repeat:Boolean = false;
			if(_bitmapData)
			{
				switch(_fillMode)
				{
					case ImageFillMode.CLIP:
						contentWidth = Math.min(unscaleWidth, _bitmapData.width);
						contentHeight = Math.min(unscaleHeight, _bitmapData.height);
						_bitmapData = clipBitmapData(_bitmapData, contentWidth, contentHeight);
						break;
					case ImageFillMode.REPEAT:
						repeat = true;
						break;
					case ImageFillMode.SCALE:
						scale = calculateScale(unscaleWidth, unscaleHeight, _bitmapData.width, _bitmapData.height);
						if(_scaleMode == ImageScaleMode.LETTERBOX)
						{
							contentWidth = scale.x * _bitmapData.width;
							contentHeight = scale.y * _bitmapData.height;
						}
						break;
				}
				startPoint = calculateStartPoint(unscaleWidth, unscaleHeight, contentWidth, contentHeight);
				drawBitmap(drawBitmapData, contentWidth, contentHeight, repeat, scale.x, scale.y, startPoint);
			}
			else
			{
				clearBitmap();
				if(_content != null)			//不是位图且有值时，只使用缩放模式
				{
					if(_fillMode == ImageFillMode.SCALE)
						scale = calculateScale(unscaleWidth, unscaleHeight, _contentOrgSize.width, _contentOrgSize.height);
					startPoint = calculateStartPoint(unscaleWidth, unscaleHeight, _contentOrgSize.width * scale.x, _contentOrgSize.height * scale.y);
					_content.scaleX = scale.x;
					_content.scaleY = scale.y;
					_content.x = startPoint.x;
					_content.y = startPoint.y;
				}
			}
		}
		
		/**
		 * 计算图像的起始点 
		 * @param displayWidth 控件的宽度
		 * @param displayHeight 控件的高度
		 * @param sourceWidth 绘制区域的宽度
		 * @param sourceHeight 绘制区域的高度
		 * @return 起始点
		 * 
		 */		
		private function calculateStartPoint(displayWidth:Number, displayHeight:Number, drawWidth:Number, drawHeight:Number):Point
		{
			var result:Point = new Point();
			switch(_horizontalAlign)
			{
				case HorizontalAlign.CENTER:
					result.x = (displayWidth - drawWidth) / 2;
					break;
				case HorizontalAlign.RIGHT:
					result.x = displayWidth - drawWidth;
					break;
			}
			switch(_verticalAlign)
			{
				case VerticalAlign.MIDDLE:
					result.y = (displayHeight - drawHeight) / 2;
					break;
				case VerticalAlign.BOTTOM:
					result.y = displayHeight - drawHeight;
					break;
			}
			return result;
		}
		/**
		 * 计算需要的缩放 
		 * @param displayWidth 控件的宽度
		 * @param displayHeight 控件的高度
		 * @param sourceWidth 源图像的宽度
		 * @param sourceHeight 源图像的高度
		 * @return 缩放值，x表示水平方向缩放值，y表示竖直方向缩放值
		 * 
		 */		
		private function calculateScale(displayWidth:Number, displayHeight:Number, sourceWidth:Number, sourceHeight:Number):Point
		{
			var scaleX:Number = displayWidth / sourceWidth;
			var scaleY:Number = displayHeight / sourceHeight
			switch(_scaleMode)
			{
				case ImageScaleMode.STRETCH:
					break;
				case ImageScaleMode.LETTERBOX:
					scaleX = scaleY = Math.min(scaleX, scaleY);
					break;
				case ImageScaleMode.ZOOM:
					scaleX = scaleY = Math.max(scaleX, scaleY);
					break;
			}
			return new Point(scaleX, scaleY);
		}
		
		/**
		 * 剪切图像 
		 * @param source 源图像
		 * @param clipWidth 剪切后的宽度
		 * @param clipHeight 剪切后高度
		 * @return 剪切后的图像
		 * 
		 */		
		private function clipBitmapData(source:BitmapData, clipWidth:Number, clipHeight:Number):BitmapData
		{
			if(clipWidth >= source.width && clipHeight >= source.height)
				return source;
			
			var result:BitmapData = new BitmapData(clipWidth, clipHeight, true, 0);
			result.copyPixels(source, new Rectangle(0, 0, clipWidth, clipHeight), new Point());
			return result;
			
		}
		
		/**
		 * 绘制图像 
		 * @param bitmapData 位图数据
		 * @param drawWidth 绘制矩形的宽度
		 * @param drawHeight 绘制矩形的高度
		 * @param repeat 是否重复
		 * @param scaleX 水平缩放
		 * @param scaleY 竖直缩放
		 * @param startPoint 矩形起始点，null表示（0，0）点
		 * 
		 */		
		private function drawBitmap(bitmapData:BitmapData, drawWidth:Number, drawHeight:Number, repeat:Boolean = false, scaleX:Number = 1, scaleY:Number = 1, startPoint:Point = null):void
		{
			if(startPoint == null)
				startPoint = new Point();
			var g:Graphics = _canvas.graphics;
			g.clear();
			if(_bitmapData != null)
			{
				var m:Matrix = null;
				m = new Matrix();
				m.createBox(scaleX, scaleY, 0, startPoint.x, startPoint.y);
				g.beginBitmapFill(bitmapData, m, repeat);
				g.drawRect(startPoint.x, startPoint.y, drawWidth, drawHeight);
				g.endFill();
			}
		}
		
		private function clearBitmap():void
		{
			var g:Graphics = _canvas.graphics;
			g.clear();
		}
		
		private function load(path:String):void
		{
			addLoaderListeners();
			_contentLoader.load(new URLRequest(path));
		}
		
		private function addLoaderListeners():void
		{
			if(_contentLoader == null)
				_contentLoader = new Loader();
			var contentInfo:LoaderInfo = _contentLoader.contentLoaderInfo;
			contentInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
			contentInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
		}
		
		private function removeLoaderListeners():void
		{
			if(_contentLoader)
			{
				var contentInfo:LoaderInfo = _contentLoader.contentLoaderInfo;
				contentInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
				contentInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			}
		}
		
		protected function loader_errorHandler(event:IOErrorEvent):void
		{
			removeLoaderListeners();
		}
		
		protected function loader_completeHandler(event:Event):void
		{
			removeLoaderListeners();
			content = _contentLoader.content;
		}
		
		/**
		 * 设置显示对象 
		 * 
		 */		
		private function set content(value:DisplayObject):void
		{
			if(_content != null)
			{
				if(_content is Bitmap)
					_bitmapData = null;
				else
				{
					$removeChild(_content);
					_content.scaleX = 1;
					_content.scaleY = 1;
				}
				_contentOrgSize = null;
			}
			_content = value;
			if(_content != null)
			{
				if(_content is Bitmap)
					_bitmapData = (_content as Bitmap).bitmapData;
				else
				{
					
					$addChild(_content);
				}
				_contentOrgSize = new Size(_content.width, _content.height);
			}
			invalidateSize();
			invalidateDisplayList();
		}
		
		/**
		 * 图像源，可以是字符串、显示对象类、显示对象 
		 */
		public function get source():*
		{
			return _source;
		}
		
		/**
		 * @private
		 */
		public function set source(value:*):void
		{
			if(_source != value)
			{
				_source = value;
				if(_source == null)
					content = null;
				else
				{
					if(_source is String)
						load(_source as String);
					else if(_source is Class)
						content = new _source();
					else if(_source is DisplayObject)
						content = _source as DisplayObject;
					else if(_source is BitmapData)
						content = new Bitmap(_source as BitmapData);
					else
						content = null;
				}
			}
		}
		
		/**
		 * 填充模式，当content是Bitmap时有效
		 */
		public function get fillMode():String
		{
			return _fillMode;
		}
		
		/**
		 * @private
		 */
		public function set fillMode(value:String):void
		{
			if(_fillMode != value)
			{
				_fillMode = value;
				invalidateSize();
				invalidateDisplayList();
			}
		}
		
		/**
		 * 缩放模式，当fillMode为scale时，此值有效 
		 */
		public function get scaleMode():String
		{
			return _scaleMode;
		}
		
		/**
		 * @private
		 */
		public function set scaleMode(value:String):void
		{
			if(_scaleMode != value)
			{
				_scaleMode = value;
				invalidateSize();
				invalidateDisplayList();
			}
		}
		
		/**
		 * 水平对齐方式 
		 */
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		/**
		 * @private
		 */
		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
			invalidateDisplayList();
		}
		
		/**
		 * 竖直对齐方式 
		 */
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		/**
		 * @private
		 */
		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
			invalidateDisplayList();
		}
	}
}