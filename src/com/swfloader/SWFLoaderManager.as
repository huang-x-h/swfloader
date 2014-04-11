package com.swfloader
{
	/**
	 * SWF加载处理
	 *  
	 * @author huangxinghui
	 * 
	 */	
	public class SWFLoaderManager
	{
		public function SWFLoaderManager()
		{
		}
		
		private static var instance:SWFLoaderManagerImpl;
		
		private static function getInstance():SWFLoaderManagerImpl
		{
			if (!instance)
				instance = new SWFLoaderManagerImpl();
			
			return instance;
		}
		
		public static function load(item:SWFItem):void
		{
			getInstance().load(item);
		}
	}
}