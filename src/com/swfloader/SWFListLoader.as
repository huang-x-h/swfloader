package com.swfloader
{
	/**
	 * swf路径列表加载
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFListLoader
	{
		private var swfUrls:Array = [];
		
		private var completeHandler:Function;
		
		private var currentIndex:int = 0;
		
		public function SWFListLoader(swfUrls:Array, completeHandler:Function)
		{
			this.swfUrls = swfUrls;
			this.completeHandler = completeHandler;
		}
		
		/**
		 * 根据给予的swf路径数组进行加载 
		 */		
		public function load():void
		{
			currentIndex = 0;
			var item:SWFItem;
			for each(var swfUrl:String in swfUrls)
			{
				item = new SWFItem();
				item.url = swfUrl;
				item.completeHandler = chainedCompleteHandler;
				item.errorHandler = chainedCompleteHandler;
				SWFLoaderManager.load(item);
			}
		}
		
		public function isDone():Boolean
		{
			return currentIndex >= swfUrls.length;
		}
		
		private function chainedCompleteHandler():void
		{
			currentIndex++;
			
			if (isDone())
			{
				if (completeHandler != null)
					completeHandler();
			}
		}
	}
}