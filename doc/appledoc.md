# appledoc

## 安装
	
	$brew install appledoc
	&appledoc --version

## 使用

> 第一步：进入代码所在文件夹
	
	`$cd path`	
	
> 第二步：生成文档

`&appledoc -o <output-path> --project-name <project_name> --progect-company <project_company>`

> 第三步：集成进我们自己的工程
	
1. 在你的工程中创建新的 Target，注意这里要选择 Other 中的 Aggregate。
+ 在我们新创建的 Target 中的 Buid Phases 中添加 Run Script。
+ 打开Run Script，Shell 下面的文档区域添加这样的模板：

```
	&appledoc Xcode script  
	&Start constants  
	company="ACME";  
	companyID="com.ACME";
	companyURL="http://ACME.com";
	target="iphoneos";
	&target="macosx";
	outputPath="~/help";
	&End constants
	/usr/local/bin/appledoc \
	--project-name "${PROJECT_NAME}" \
	--project-company "${company}" \
	--company-id "${companyID}" \
	--docset-atom-filename "${company}.atom" \
	--docset-feed-url "${companyURL}/${company}/	%DOCSETATOMFILENAME" \
	--docset-package-url "${companyURL}/${company}/	%DOCSETPACKAGEFILENAME" \
	--docset-fallback-url "${companyURL}/${company}" \
	--output "${outputPath}" \
	--publish-docset \
	--docset-platform-family "${target}" \
	--logformat xcode \
	--keep-intermediate-files \
	--no-repeat-first-par \
	--no-warn-invalid-crossref \
	--exit-threshold 2 \
	"${PROJECT_DIR}"
```

4. Xcode 左上方选择这个 Target ，然后 Build 编译。
+ 文档就会编译好并且自动安装进 Xcode 了（重启Xcode生效）。
* 那么编译之后我们就可以去查看它了，那么在哪里可以看到呢？这时我们就可以用之前生成的 docset-installed.txt文件啦，打开它：看到以一个 Path 了吧：直接复制，然后在 Finder 中前往文件夹。
7. 如果顺利的话我们就会看到这里啦：这个就是你生成的包文件，右键 --> 显示包内容你就会看到你的注释文件们啦，自己好好找喽。
	

