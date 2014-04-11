package com.swfloader
{
	[ExcludeClass]
	
	/**
	 * swf加载等待队列
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFWaitingQueue
	{
		private var waitingQueue:Object = {};
		
		private static var instance:SWFWaitingQueue;
		
		public function SWFWaitingQueue()
		{
		}
		
		public static function getInstance():SWFWaitingQueue
		{
			if (!instance)
				instance = new SWFWaitingQueue();
			
			return instance;
		}
		
		public function add(item:SWFItem):void
		{
			if (item.url in waitingQueue)
			{
				waitingQueue[item.url].push(item);
			}
			else
			{
				waitingQueue[item.url] = [item];
			}
		}
		
		public function remove(url:String):Array
		{
			var result:Array = waitingQueue[url];
			delete waitingQueue[url];
			return result;
		}
		
		public function contain(url:String):Boolean
		{
			return url in waitingQueue;
		}
	}
}