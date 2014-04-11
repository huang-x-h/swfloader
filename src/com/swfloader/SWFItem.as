package com.swfloader
{
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * 加载swf信息
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFItem
	{
		private var urlRequest:URLRequest;
		
		private var errorText:String;
		
		private var completed:Boolean = false;
		
		private var chainedProgressHandler:Function;    
		private var chainedCompleteHandler:Function;
		private var chainedIOErrorHandler:Function;
		private var chainedSecurityErrorHandler:Function;
		
		private var _url:String;

		/**
		 * swf加载路径
		 *  
		 * @return String
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}
		
		private var _completeHandler:Function;

		/**
		 * swf加载完毕处理函数
		 *  
		 * @return Function
		 * 
		 */		
		public function get completeHandler():Function
		{
			return _completeHandler;
		}

		public function set completeHandler(value:Function):void
		{
			_completeHandler = value;
		}
		
		private var _errorHandler:Function;

		/**
		 * swf加载失败处理函数
		 *  
		 * @return Function
		 * 
		 */		
		public function get errorHandler():Function
		{
			return _errorHandler;
		}

		public function set errorHandler(value:Function):void
		{
			_errorHandler = value;
		}
		
		public function SWFItem()
		{
			super();
		}
		
		internal function load(progressHandler:Function,
							 completeHandler:Function,
							 ioErrorHandler:Function,
							 securityErrorHandler:Function):void 
		{
			chainedProgressHandler = progressHandler;
			chainedCompleteHandler = completeHandler;
			chainedIOErrorHandler = ioErrorHandler;
			chainedSecurityErrorHandler = securityErrorHandler;
			
			var loader:Loader = new Loader();               
			var loaderContext:LoaderContext = new LoaderContext();
			urlRequest = new URLRequest(url);
			
			// The RSLItem needs to listen to certain events.
			
			loader.contentLoaderInfo.addEventListener(
				ProgressEvent.PROGRESS, itemProgressHandler);
			
			loader.contentLoaderInfo.addEventListener(
				Event.COMPLETE, itemCompleteHandler);
			
			loader.contentLoaderInfo.addEventListener(
				IOErrorEvent.IO_ERROR, itemErrorHandler);
			
			loader.contentLoaderInfo.addEventListener(
				SecurityErrorEvent.SECURITY_ERROR, itemErrorHandler);
			
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			loader.load(urlRequest, loaderContext); 
		}
		
		internal function doCompleteHanlder():void
		{
			if (_completeHandler != null)
				_completeHandler();
		}
		
		internal function doErrorHandler():void
		{
			if (_errorHandler != null)
				_errorHandler();
		}
		
		private function itemProgressHandler(event:ProgressEvent):void
		{
			// Notify an external listener
			if (chainedProgressHandler != null)
				chainedProgressHandler(event);
		}
		
		/**
		 *  @private
		 */
		private function itemCompleteHandler(event:Event):void
		{
			completed = true;
			
			// Notify an external listener
			if (chainedCompleteHandler != null)
				chainedCompleteHandler(event);
			
			doCompleteHanlder();
		}
		
		/**
		 *  @private
		 */
		private function itemErrorHandler(event:ErrorEvent):void
		{
			errorText = decodeURI(event.text);
			completed = true;
			
			trace(errorText);
			
			// Notify an external listener
			if (event.type == IOErrorEvent.IO_ERROR &&
				chainedIOErrorHandler != null)
			{
				chainedIOErrorHandler(event);
			}
			else if (event.type == SecurityErrorEvent.SECURITY_ERROR && 
				chainedSecurityErrorHandler != null)
			{
				chainedSecurityErrorHandler(event);
			}
			
			doErrorHandler();
		}
	}
}