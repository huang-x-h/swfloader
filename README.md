swfloader
=========

swf加载器，用于在flex中缓存加载swf文件。可用于组件模块化，加载然后反射得到相应类

加载swf文件提供单个加载和多个加载方式



- 单个加载方式：

		var item:SWFItem = new SWFItem();
		item.url = "module/MyButtonComp.swf";
		item.completeHandler = function():void {
			trace("load complete");
		};
		
		SWFLoaderManager.load(item);

- 多个加载方式：

		var loader:SWFListLoader = new SWFListLoader(["module/MyTextComp.swf", "module/MyLoginComp.swf"], function():void {
			trace("load complete");
		});
		
		loader.load();
