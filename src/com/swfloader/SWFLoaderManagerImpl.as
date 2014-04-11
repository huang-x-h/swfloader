package com.swfloader
{
	import flash.events.Event;
	
	import mx.managers.CursorManager;
	
	[ExcludeClass]

	/**
	 * SWF加载处理实现
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFLoaderManagerImpl
	{
		public function SWFLoaderManagerImpl()
		{
		}
		
		private var swfList:Array = [];
		
		private var currentItem:SWFItem;
		
		private var swfCache:SWFCache = SWFCache.getInstance();
		
		private var swfWaitingQueue:SWFWaitingQueue = SWFWaitingQueue.getInstance();
		
		/**
		 * swf加载
		 *  
		 * @param item
		 * 
		 */		
		public function load(item:SWFItem):void 
		{
			if (item.url)
			{
				if (swfCache.contain(item.url))
				{
					if (swfCache.isComplete(item.url))
					{
						item.doCompleteHanlder();
					}
					else
					{
						swfWaitingQueue.add(item);
					}
				}
				else
				{
					if (isDone())
					{
						CursorManager.setBusyCursor();
						swfCache.add(item.url);
						swfList.push(item);
						loadNext();
					}
					else
					{
						swfCache.add(item.url);
						swfList.push(item);
					}
				}
			}
		}
		
		private function loadNext():void
		{
			if (isDone())
			{
				CursorManager.removeBusyCursor();
			}
			else
			{
				currentItem = swfList[0];
				currentItem.load(listProgressHandler,
					listCompleteHandler,
					listErrorHandler,
					listErrorHandler);
			}
		}
		
		private function isDone():Boolean
		{
			return swfList.length == 0;
		}
		
		private function listProgressHandler(event:Event):void
		{
			// do nothing
		}
		
		private function listCompleteHandler(event:Event):void
		{
			swfList.shift();
			swfCache.complete(currentItem.url);
			
			if (swfWaitingQueue.contain(currentItem.url))
			{
				var waitingQueue:Array = swfWaitingQueue.remove(currentItem.url);
				
				for each(var item:SWFItem in waitingQueue)
				{
					item.doCompleteHanlder();
				}
			}
			loadNext();
		}
		
		private function listErrorHandler(event:Event):void
		{
			swfList.shift();
			// 没有加载成功，则不计入缓存中
			swfCache.remove(currentItem.url);
			
			if (swfWaitingQueue.contain(currentItem.url))
			{
				var waitingQueue:Array = swfWaitingQueue.remove(currentItem.url);
				
				for each(var item:SWFItem in waitingQueue)
				{
					item.doErrorHandler();
				}
			}
			
			loadNext();
		}
	}
}