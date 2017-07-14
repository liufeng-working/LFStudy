# CocoaPods的安装和使用
---
[CocoaPos官网](https://cocoapods.org)

## 安装
安装方式异常简单，Mac下都自带ruby，使用ruby的gem命令即可下载安装:

	$sudo gem install cocoapods
	$pod setup

如果你的gem太老，可以尝试用如下命令升级gem:

	$sudo gem update --system
	
另外，ruby的软件源`https://rubygems.org`因为使用亚马逊的云服务，所以被屏蔽了，需要更新一下ruby的源，可以将官方的ruby源替换成国内淘宝的源`https://ruby.taobao.org`或者国内镜像`https://gems.ruby-china.org`:

	$gem sources --remove https://rubygems.org
	$gem sources -a https://ruby.taobao.org

然后查看当前源：

	$gem sources -l
	
还有一点需要注意，pod setup在执行时，会输出setting CocoaPods master remo，但是会等待比较久的时间。这步其实是           在将它的信息下载到~/.CocoaPods目录下，如果你等太久，可以试着cd到那个目录，用du -sh *来查看下载进度。下一节将使用“CocoaPods的镜像索引”来提高下载速度。

## CocoaPods的镜像索引
所有项目的Podspec文件都托管在`https://github.com/CocoaPods/Specs`。第一次执行pod setup时，CocoaPods会将这些索引文件更新到本地的~/.cocoapods目录下，这个索引文件比较大，所以第一次更新时非常慢。

一个叫akinliu`http://akinliu.github.io/2014/05/03/cocoapods-specs-`的朋友在gitcafe`http://gitcafe.com`和        occhina`http://www.oschina.net`上建立了CocoaPods索引库的镜像，因为都是国内的服务器，所以在执行索引更新操作时，会快很多。如下操作可以将CocoaPods设置成使用镜像：
	
	$pod repo remove master
	$pod repo add master https://gitcafe.com/akuandev/Specs.git
	$pod repo update
	
将以上代码中的`https://gitcafe.com/akuandev/Specs.git`替换成`http://oschina.net/akuan`即可使用scchina上的镜像。

## 使用CocoaPods
使用时需要新建一个名为Podfile的文件，以如下格式，将依赖的库名字依次列在文件中即可:

	platform: ios, 9.0
	target 'targetName’ do
	pod 'Masonry', '~> 1.0.0'
	pod 'SDWebImage', '~> 1.0.0'
	pod 'AFNetworking', '~> 1.0.0' 
	end
	
然后将编辑好的Podfile文件放到项目根目录中，执行如下命令即可:

	$pod install
	
现在，所有第三方库都已经下载完成并且设置好了编译参数和依赖，你只需要记住如下两点即可:

	1. 使用CocoaPods生成的*.xcworkspace文件来打开工程，而不是以前的*.xocdeproj文件。
	2.每次更改了Podfile文件，都需要重新执行一次pod install命令。
	
## 查找第三方
如果不知道CocoaPods管理的库中是否有你想要的库，那么你可以通过以下命令进行查找：
	
	$pod search AFNetWorking
	
## 注意事项
### 关于.gitignore
当你执行`pod install`之后，除了Podfile外，CocoaPods还会生成一个名为Podfile.lock的文件，你不应该把这个文件加入到.gitignore中。因为Podfile.lock会锁定当前各依赖库的版本，之后如果多次执行`pod install`不会更改版本，要执行`pod update`才会改变Podfile.lock。这样多人协作的时候，可以防止第三方库升级时造成大家各自的第三方库版本不一致。

### 为自己的项目创建podspec文件
我们可以为自己的开源项目创建podspec文件，首先通过如下命令初始化一个podspec文件：

	$pod spec create test
	
该命令执行之后，CocoaPods会生成一个名为test.podspec的文件，然后我们修改其中的相关内容即可。

```
#
#  Be sure to run `pod spec lint test.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "test"
  s.version      = "0.0.1"
  s.summary      = "A short description of test."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                   DESC

  s.homepage     = "http://EXAMPLE/test"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT (example)"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "liufeng-working" => "2992188442@qq.com" }
  # Or just: s.author    = "liufeng-working"
  # s.authors            = { "liufeng-working" => "2992188442@qq.com" }
  # s.social_media_url   = "http://twitter.com/liufeng-working"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "http://EXAMPLE/test.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
```

### 使用私有的pods
我们可以直接指定某一个依赖的podspec，这样就可以使用公司内部的私有库。该方案有利于使企业内部的公共项目支持CocoaPods。如下是一个示例:

	pod 'test', :podspec => 'url'
	
### 不更新podspec
CocoaPods在执行pod install和pod update时，会默认先更新podspec索引。使用`--no-repo-update`参数可以禁止其做索引跟心操作。如下：

	$pod install --no-repo-update
	$pod update --no-repo-update
	
### 生成第三方库的帮助文档
如果你想让CocoaPods帮你生成第三方库的帮助文档，并集成到Xcode中，那么用brew安装appledoc即可:
	
	$brew install appledoc

关于appledoc，它最大的优点是可以将帮助文档集成到Xcode中，这样你在敲代码的时候，按住option键单击类名或方法名，就可以显示出相应的帮助文档。

### 原理
CocoaPods的原理是将所有的依赖库都放到另一个名为Pods的项目中，然后让主项目依赖Pods项目，这样，源码管理工作都从主项目移到了Pods项目中。发现的一些技术细节有:	1. 项目最终会编译成一个名为libPods.a的文件，主项目只需要依赖这个.a文件即可。
	2. 对于资源文件，CocoaPods提供了一个名为Pods-resources.sh的bash脚本，该脚本在每次项目编译的时候都会执行，将第三方库的各种资源文件复制到目标目录中。
	3. 通过一个名为Pods.xcconfig的文件在编译时设置所有的依赖和参数。