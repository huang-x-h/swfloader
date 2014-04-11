swfloader
=========

swf加载器，用于在flex中缓存加载swf文件。

加载进来的swf是同Application应用作用域，这样就可以通过类名来进行反射得到类来创建实例。可用于组件模块化加载。[查看示例](http://huang-x-h.github.io/swfloader)

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
