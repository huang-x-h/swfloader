#swfloader
=========

swf加载器，用于在flex中缓存加载swf文件。

可用于组件模块化加载。加载完成的组件，下次加载可直接从`SWFCache`中根据url获取相应内容，避免重复加载[查看示例](http://huang-x-h.github.io/swfloader)

## 单个加载方式：

		var item:SWFItem = new SWFItem();
		item.url = "module/MyButtonComp.swf";
		item.completeHandler = function():void {
			trace("load complete");
		};
		
		SWFLoaderManager.load(item);

## 多个加载方式，传递swf字符串数组，内部实现去加载相应swf存放到缓存中：

		var loader:SWFListLoader = new SWFListLoader(["module/MyTextComp.swf", "module/MyLoginComp.swf"], function():void {
			trace("load complete");
		});
		
		loader.load();

## ChangeLog

	2014-11-30 
	
	- `SWFItem` 新增`content`属性，提供`get`/`set`方法
	- `SWFCache` 新增`get`方法用户获取`swf`内容，修改`complete`方法增加个参数
	