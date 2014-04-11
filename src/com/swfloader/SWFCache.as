package com.swfloader
{
	[ExcludeClass]
	/**
	 * swf缓存
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFCache
	{
		public function SWFCache()
		{
		}
		
		private static var instance:SWFCache;
		
		private var swfCache:Object = {};
		
		public static function getInstance():SWFCache
		{
			if (!instance)
				instance = new SWFCache();
			
			return instance;
		}
		
		public function add(url:String):void
		{
			swfCache[url] = false;
		}
		
		public function remove(url:String):void
		{
			delete swfCache[url];
		}
		
		public function contain(url:String):Boolean
		{
			return url in swfCache;
		}
		
		public function complete(url:String):void
		{
			swfCache[url] = true;
		}
		
		public function isComplete(url:String):Boolean
		{
			return swfCache[url];
		}
	}
}