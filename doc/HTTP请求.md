# **HTTP请求**

[原文地址](http://www.runoob.com/http/http-tutorial.html)

## HTTP简介
HTTP协议是Hyper Text Transfer Protocol（超文本传输协议）的缩写,是用于从万维网（WWW:World Wide Web）服务器传输超文本到本地的传送协议。

HTTP是一个基于TCP/IP通信协议来传递数据（HTML文件, 图片文件, 查询结果等）。

## HTTP工作原理
HTTP协议工作于客户端-服务端架构为上。浏览器作为HTTP客户端通过URL向HTTP服务端即WEB服务器发送所有请求。

Web服务器有：Apache服务器，IIS服务器（Internet Information Services）等。

Web服务器根据接收到的请求，向客户端发送响应信息。

HTTP默认端口号为80，但是你也可以改为8080或者其他端口。

##### HTTP三点注意事项：

1. HTTP是无连接：无连接的含义是限制每次连接只处理一个请求。服务器处理完客户的请求，并收到客户的应答后，即断开连接。采用这种方式可以节省传输时间。
2. HTTP是媒体独立的：这意味着，只要客户端和服务器知道如何处理的数据内容，任何类型的数据都可以通过HTTP发送。客户端以及服务器指定使用适合的MIME-type内容类型。
3. HTTP是无状态：HTTP协议是无状态协议。无状态是指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则它必须重传，这样可能导致每次连接传送的数据量增大。另一方面，在服务器不需要先前信息时它的应答就较快。

## HTTP请求方法
根据HTTP标准，HTTP请求可以使用多种请求方法。  
HTTP1.0定义了三种请求方法：GET, POST和HEAD方法。  
HTTP1.1新增了五种请求方法：OPTIONS, PUT, DELETE, TRACE和CONNECT方法。

| 序号 | 方法 | 描述 |
| :-: | :-: | :-: |
| 1 | GET | 请求指定的页面信息，并返回实体主体 |
| 2 | HEAD | 类似于get请求，只不过返回的响应中没有具体的内容，用于获取报头 |
| 3 | POST | 向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的建立和/或已有资源的修改。 |
| 4 | PUT | 从客户端向服务器传送的数据取代指定的文档的内容 |
| 5 | DELETE | 请求服务器删除指定的页面 |
| 6 | CONNECT | HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器 |
| 7 | OPTIONS | 允许客户端查看服务器的性能 |
| 8 | TRACE | 回显服务器收到的请求，主要用于测试或诊断 |

## HTTP头信息

| 序号 | 应答头 | 说明 |
| :-: | :---: | :-: |
| 1 | Allow  | 服务器支持哪些请求方法（如GET、POST等） |
| 2 | Content-Encoding  | 文档的编码（Encode）方法。只有在解码之后才可以得到Content-Type头指定的内容类型。利用gzip压缩文档能够显著地减少HTML文档的下载时间。因此，Servlet应该通过查看Accept-Encoding头，检查浏览器是否支持gzip，为支持gzip的浏览器返回经gzip压缩的HTML页面，为其他浏览器返回普通页面 |
| 3 | Content-Length  | 表示内容长度。只有当浏览器使用持久HTTP连接时才需要这个数据。 |
| 4 | Content-Type  | 表示后面的文档属于什么MIME类型。Servlet默认为text/plain，但通常需要显式地指定为text/html。由于经常要设置Content-Type，因此HttpServletResponse提供了一个专用的方法setContentType |
| 5 | Date  | 当前的GMT时间。你可以用setDateHeader来设置这个头以避免转换时间格式的麻烦 |
| 6 | Expires  | 应该在什么时候认为文档已经过期，从而不再缓存它 |
| 7 | Last-Modified  | 文档的最后改动时间。客户可以通过If-Modified-Since请求头提供一个日期，该请求将被视为一个条件GET，只有改动时间迟于指定时间的文档才会返回，否则返回一个304（Not Modified）状态。 |
| 8 | Location  | 表示客户应当到哪里去提取文档。 |
| 9 | Refresh  | 表示浏览器应该在多少时间之后刷新文档，以秒计。注意Refresh的意义是"N秒之后刷新本页面或访问指定页面"，而不是"每隔N秒刷新本页面或访问指定页面"。因此，连续刷新要求每次都发送一个Refresh头，而发送204状态代码则可以阻止浏览器继续刷新。注意Refresh头不属于HTTP 1.1正式规范的一部分，而是一个扩展，但Netscape和IE都支持它 |
| 10 | Server  | 服务器名字。Servlet一般不设置这个值，而是由Web服务器自己设置 |
| 11 | Set-Cookie  | 设置和页面关联的Cookie |
| 12 | WWW-Authenticate  | 客户应该在Authorization头中提供什么类型的授权信息？在包含401（Unauthorized）状态行的应答中这个头是必需的。注意Servlet一般不进行这方面的处理，而是让Web服务器的专门机制来控制受密码保护页面的访问（例如.htaccess） |

## HTTP状态码
当浏览者访问一个网页时，浏览者的浏览器会向网页所在服务器发出请求。当浏览器接收并显示网页前，此网页所在的服务器会返回一个包含HTTP状态码的信息头（server header）用以响应浏览器的请求。
HTTP状态码的英文为HTTP Status Code。

下面是常见的HTTP状态码：

* 200 - 请求成功
* 301 - 资源（网页等）被永久转移到其它URL
* 404 - 请求的资源（网页等）不存在
* 500 - 内部服务器错误

#### HTTP状态码分类
HTTP状态码由三个十进制数字组成，第一个十进制数字定义了状态码的类型，后两个数字没有分类的作用。HTTP状态码共分为5种类型：

| 代号 | 类型 | 分类描述 |
| :-: | :--: | :-----: |
| 1** | 信息 | 服务器收到请求，需要请求者继续执行操作 |
| 2** | 成功 | 操作被成功接收并处理 |
| 3** | 重定向 | 需要进一步的操作以完成请求 |
| 4** | 客户端错误 | 请求包含语法错误或无法完成请求 |
| 5** | 服务器错误 | 服务器在处理请求的过程中发生了错误 |

[更详细全面的状态码](http://tool.oschina.net/commons?type=5)：
		
| 状态码 | 含义 | 
| :---: | :--: |
| 100 | 客户端应当继续发送请求。这个临时响应是用来通知客户端它的部分请求已经被服务器接收，且仍未被拒绝。客户端应当继续发送请求的剩余部分，或者如果请求已经完成，忽略这个响应。服务器必须在请求完成后向客户端发送一个最终响应。 | 
| 101 | 服务器已经理解了客户端的请求，并将通过Upgrade 消息头通知客户端采用不同的协议来完成这个请求。在发送完这个响应最后的空行后，服务器将会切换到在Upgrade 消息头中定义的那些协议。 　　只有在切换新的协议更有好处的时候才应该采取类似措施。例如，切换到新的HTTP 版本比旧版本更有优势，或者切换到一个实时且同步的协议以传送利用此类特性的资源。 | 
| 102 | 由WebDAV（RFC 2518）扩展的状态码，代表处理将被继续执行。 |
| 200 | 请求已成功，请求所希望的响应头或数据体将随此响应返回。 |
| 201 | 请求已经被实现，而且有一个新的资源已经依据请求的需要而建立，且其 URI 已经随Location 头信息返回。假如需要的资源无法及时建立的话，应当返回 ‘202 Accepted‘。 |
| 202 | 服务器已接受请求，但尚未处理。正如它可能被拒绝一样，最终该请求可能会也可能不会被执行。在异步操作的场合下，没有比发送这个状态码更方便的做法了。 　　返回202状态码的响应的目的是允许服务器接受其他过程的请求（例如某个每天只执行一次的基于批处理的操作），而不必让客户端一直保持与服务器的连接直到批处理操作全部完成。在接受请求处理并返回202状态码的响应应当在返回的实体中包含一些指示处理当前状态的信息，以及指向处理状态监视器或状态预测的指针，以便用户能够估计操作是否已经完成。 |
| 203 | 服务器已成功处理了请求，但返回的实体头部元信息不是在原始服务器上有效的确定集合，而是来自本地或者第三方的拷贝。当前的信息可能是原始版本的子集或者超集。例如，包含资源的元数据可能导致原始服务器知道元信息的超级。使用此状态码不是必须的，而且只有在响应不使用此状态码便会返回200 OK的情况下才是合适的。 |
| 204 | 服务器成功处理了请求，但不需要返回任何实体内容，并且希望返回更新了的元信息。响应可能通过实体头部的形式，返回新的或更新后的元信息。如果存在这些头部信息，则应当与所请求的变量相呼应。 　　如果客户端是浏览器的话，那么用户浏览器应保留发送了该请求的页面，而不产生任何文档视图上的变化，即使按照规范新的或更新后的元信息应当被应用到用户浏览器活动视图中的文档。 　　由于204响应被禁止包含任何消息体，因此它始终以消息头后的第一个空行结尾。 |
| 205 | 服务器成功处理了请求，且没有返回任何内容。但是与204响应不同，返回此状态码的响应要求请求者重置文档视图。该响应主要是被用于接受用户输入后，立即重置表单，以便用户能够轻松地开始另一次输入。 　　与204响应一样，该响应也被禁止包含任何消息体，且以消息头后的第一个空行结束。 |
| 206 | 服务器已经成功处理了部分 GET 请求。类似于 FlashGet 或者迅雷这类的 HTTP 下载工具都是使用此类响应实现断点续传或者将一个大文档分解为多个下载段同时下载。 　　该请求必须包含 Range 头信息来指示客户端希望得到的内容范围，并且可能包含 If-Range 来作为请求条件。 　　响应必须包含如下的头部域： 　　Content-Range 用以指示本次响应中返回的内容的范围；如果是 Content-Type 为 multipart/byteranges 的多段下载，则每一multipart 段中都应包含 Content-Range 域用以指示本段的内容范围。假如响应中包含 Content-Length，那么它的数值必须匹配它返回的内容范围的真实字节数。 　　Date 　　ETag 和/或 Content-Location，假如同样的请求本应该返回200响应。 　　Expires, Cache-Control，和/或 Vary，假如其值可能与之前相同变量的其他响应对应的值不同的话。 　　假如本响应请求使用了 If-Range 强缓存验证，那么本次响应不应该包含其他实体头；假如本响应的请求使用了 If-Range 弱缓存验证，那么本次响应禁止包含其他实体头；这避免了缓存的实体内容和更新了的实体头信息之间的不一致。否则，本响应就应当包含所有本应该返回200响应中应当返回的所有实体头部域。 　　假如 ETag 或 Last-Modified 头部不能精确匹配的话，则客户端缓存应禁止将206响应返回的内容与之前任何缓存过的内容组合在一起。 　　任何不支持 Range 以及 Content-Range 头的缓存都禁止缓存206响应返回的内容。 |
| 207 | 由WebDAV(RFC 2518)扩展的状态码，代表之后的消息体将是一个XML消息，并且可能依照之前子请求数量的不同，包含一系列独立的响应代码。 |
| 300 | 被请求的资源有一系列可供选择的回馈信息，每个都有自己特定的地址和浏览器驱动的商议信息。用户或浏览器能够自行选择一个首选的地址进行重定向。 　　除非这是一个 HEAD 请求，否则该响应应当包括一个资源特性及地址的列表的实体，以便用户或浏览器从中选择最合适的重定向地址。这个实体的格式由 Content-Type 定义的格式所决定。浏览器可能根据响应的格式以及浏览器自身能力，自动作出最合适的选择。当然，RFC 2616规范并没有规定这样的自动选择该如何进行。 　　如果服务器本身已经有了首选的回馈选择，那么在 Location 中应当指明这个回馈的 URI；浏览器可能会将这个 Location 值作为自动重定向的地址。此外，除非额外指定，否则这个响应也是可缓存的。 |
| 301 | 被请求的资源已永久移动到新位置，并且将来任何对此资源的引用都应该使用本响应返回的若干个 URI 之一。如果可能，拥有链接编辑功能的客户端应当自动把请求的地址修改为从服务器反馈回来的地址。除非额外指定，否则这个响应也是可缓存的。 　　新的永久性的 URI 应当在响应的 Location 域中返回。除非这是一个 HEAD 请求，否则响应的实体中应当包含指向新的 URI 的超链接及简短说明。 　　如果这不是一个 GET 或者 HEAD 请求，因此浏览器禁止自动进行重定向，除非得到用户的确认，因为请求的条件可能因此发生变化。 　　注意：对于某些使用 HTTP/1.0 协议的浏览器，当它们发送的 POST 请求得到了一个301响应的话，接下来的重定向请求将会变成 GET 方式。 |
| 302 | 请求的资源现在临时从不同的 URI 响应请求。由于这样的重定向是临时的，客户端应当继续向原有地址发送以后的请求。只有在Cache-Control或Expires中进行了指定的情况下，这个响应才是可缓存的。 　　新的临时性的 URI 应当在响应的 Location 域中返回。除非这是一个 HEAD 请求，否则响应的实体中应当包含指向新的 URI 的超链接及简短说明。 　　如果这不是一个 GET 或者 HEAD 请求，那么浏览器禁止自动进行重定向，除非得到用户的确认，因为请求的条件可能因此发生变化。 　　注意：虽然RFC 1945和RFC 2068规范不允许客户端在重定向时改变请求的方法，但是很多现存的浏览器将302响应视作为303响应，并且使用 GET 方式访问在 Location 中规定的 URI，而无视原先请求的方法。状态码303和307被添加了进来，用以明确服务器期待客户端进行何种反应。 |
| 303 | 对应当前请求的响应可以在另一个 URI 上被找到，而且客户端应当采用 GET 的方式访问那个资源。这个方法的存在主要是为了允许由脚本激活的POST请求输出重定向到一个新的资源。这个新的 URI 不是原始资源的替代引用。同时，303响应禁止被缓存。当然，第二个请求（重定向）可能被缓存。 　　新的 URI 应当在响应的 Location 域中返回。除非这是一个 HEAD 请求，否则响应的实体中应当包含指向新的 URI 的超链接及简短说明。 　　注意：许多 HTTP/1.1 版以前的 浏览器不能正确理解303状态。如果需要考虑与这些浏览器之间的互动，302状态码应该可以胜任，因为大多数的浏览器处理302响应时的方式恰恰就是上述规范要求客户端处理303响应时应当做的。 |
| 304| 如果客户端发送了一个带条件的 GET 请求且该请求已被允许，而文档的内容（自上次访问以来或者根据请求的条件）并没有改变，则服务器应当返回这个状态码。304响应禁止包含消息体，因此始终以消息头后的第一个空行结尾。 　　该响应必须包含以下的头信息： 　　Date，除非这个服务器没有时钟。假如没有时钟的服务器也遵守这些规则，那么代理服务器以及客户端可以自行将 Date 字段添加到接收到的响应头中去（正如RFC 2068中规定的一样），缓存机制将会正常工作。 　　ETag 和/或 Content-Location，假如同样的请求本应返回200响应。 　　Expires, Cache-Control，和/或Vary，假如其值可能与之前相同变量的其他响应对应的值不同的话。 　　假如本响应请求使用了强缓存验证，那么本次响应不应该包含其他实体头；否则（例如，某个带条件的 GET 请求使用了弱缓存验证），本次响应禁止包含其他实体头；这避免了缓存了的实体内容和更新了的实体头信息之间的不一致。 　　假如某个304响应指明了当前某个实体没有缓存，那么缓存系统必须忽视这个响应，并且重复发送不包含限制条件的请求。 　　假如接收到一个要求更新某个缓存条目的304响应，那么缓存系统必须更新整个条目以反映所有在响应中被更新的字段的值。 |
| 305 | 被请求的资源必须通过指定的代理才能被访问。Location 域中将给出指定的代理所在的 URI 信息，接收者需要重复发送一个单独的请求，通过这个代理才能访问相应资源。只有原始服务器才能建立305响应。 　　注意：RFC 2068中没有明确305响应是为了重定向一个单独的请求，而且只能被原始服务器建立。忽视这些限制可能导致严重的安全后果。 |
| 306 | 在最新版的规范中，306状态码已经不再被使用。 |
| 307 | 请求的资源现在临时从不同的URI 响应请求。由于这样的重定向是临时的，客户端应当继续向原有地址发送以后的请求。只有在Cache-Control或Expires中进行了指定的情况下，这个响应才是可缓存的。 　　新的临时性的URI 应当在响应的 Location 域中返回。除非这是一个HEAD 请求，否则响应的实体中应当包含指向新的URI 的超链接及简短说明。因为部分浏览器不能识别307响应，因此需要添加上述必要信息以便用户能够理解并向新的 URI 发出访问请求。 　　如果这不是一个GET 或者 HEAD 请求，那么浏览器禁止自动进行重定向，除非得到用户的确认，因为请求的条件可能因此发生变化。 |
| 400 | 1、语义有误，当前请求无法被服务器理解。除非进行修改，否则客户端不应该重复提交这个请求。 　　2、请求参数有误。 |
| 401 | 当前请求需要用户验证。该响应必须包含一个适用于被请求资源的 WWW-Authenticate 信息头用以询问用户信息。客户端可以重复提交一个包含恰当的 Authorization 头信息的请求。如果当前请求已经包含了 Authorization 证书，那么401响应代表着服务器验证已经拒绝了那些证书。如果401响应包含了与前一个响应相同的身份验证询问，且浏览器已经至少尝试了一次验证，那么浏览器应当向用户展示响应中包含的实体信息，因为这个实体信息中可能包含了相关诊断信息。参见RFC 2617。 |
| 402 | 该状态码是为了将来可能的需求而预留的。 |
| 403 | 服务器已经理解请求，但是拒绝执行它。与401响应不同的是，身份验证并不能提供任何帮助，而且这个请求也不应该被重复提交。如果这不是一个 HEAD 请求，而且服务器希望能够讲清楚为何请求不能被执行，那么就应该在实体内描述拒绝的原因。当然服务器也可以返回一个404响应，假如它不希望让客户端获得任何信息。 |
| 404 | 请求失败，请求所希望得到的资源未被在服务器上发现。没有信息能够告诉用户这个状况到底是暂时的还是永久的。假如服务器知道情况的话，应当使用410状态码来告知旧资源因为某些内部的配置机制问题，已经永久的不可用，而且没有任何可以跳转的地址。404这个状态码被广泛应用于当服务器不想揭示到底为何请求被拒绝或者没有其他适合的响应可用的情况下。 |
| 405 | 请求行中指定的请求方法不能被用于请求相应的资源。该响应必须返回一个Allow 头信息用以表示出当前资源能够接受的请求方法的列表。 　　鉴于 PUT，DELETE 方法会对服务器上的资源进行写操作，因而绝大部分的网页服务器都不支持或者在默认配置下不允许上述请求方法，对于此类请求均会返回405错误。 |
| 406 | 请求的资源的内容特性无法满足请求头中的条件，因而无法生成响应实体。 　　除非这是一个 HEAD 请求，否则该响应就应当返回一个包含可以让用户或者浏览器从中选择最合适的实体特性以及地址列表的实体。实体的格式由 Content-Type 头中定义的媒体类型决定。浏览器可以根据格式及自身能力自行作出最佳选择。但是，规范中并没有定义任何作出此类自动选择的标准。 |
| 407 | 与401响应类似，只不过客户端必须在代理服务器上进行身份验证。代理服务器必须返回一个 Proxy-Authenticate 用以进行身份询问。客户端可以返回一个 Proxy-Authorization 信息头用以验证。参见RFC 2617。 |
| 408 | 请求超时。客户端没有在服务器预备等待的时间内完成一个请求的发送。客户端可以随时再次提交这一请求而无需进行任何更改。 |
| 409 | 由于和被请求的资源的当前状态之间存在冲突，请求无法完成。这个代码只允许用在这样的情况下才能被使用：用户被认为能够解决冲突，并且会重新提交新的请求。该响应应当包含足够的信息以便用户发现冲突的源头。 　　冲突通常发生于对 PUT 请求的处理中。例如，在采用版本检查的环境下，某次 PUT 提交的对特定资源的修改请求所附带的版本信息与之前的某个（第三方）请求向冲突，那么此时服务器就应该返回一个409错误，告知用户请求无法完成。此时，响应实体中很可能会包含两个冲突版本之间的差异比较，以便用户重新提交归并以后的新版本。 |
| 410 | 被请求的资源在服务器上已经不再可用，而且没有任何已知的转发地址。这样的状况应当被认为是永久性的。如果可能，拥有链接编辑功能的客户端应当在获得用户许可后删除所有指向这个地址的引用。如果服务器不知道或者无法确定这个状况是否是永久的，那么就应该使用404状态码。除非额外说明，否则这个响应是可缓存的。 　　410响应的目的主要是帮助网站管理员维护网站，通知用户该资源已经不再可用，并且服务器拥有者希望所有指向这个资源的远端连接也被删除。这类事件在限时、增值服务中很普遍。同样，410响应也被用于通知客户端在当前服务器站点上，原本属于某个个人的资源已经不再可用。当然，是否需要把所有永久不可用的资源标记为‘410 Gone‘，以及是否需要保持此标记多长时间，完全取决于服务器拥有者。 |
| 411 | 服务器拒绝在没有定义 Content-Length 头的情况下接受请求。在添加了表明请求消息体长度的有效 Content-Length 头之后，客户端可以再次提交该请求。 |
| 412 | 服务器在验证在请求的头字段中给出先决条件时，没能满足其中的一个或多个。这个状态码允许客户端在获取资源时在请求的元信息（请求头字段数据）中设置先决条件，以此避免该请求方法被应用到其希望的内容以外的资源上。 |
| 413 | 服务器拒绝处理当前请求，因为该请求提交的实体数据大小超过了服务器愿意或者能够处理的范围。此种情况下，服务器可以关闭连接以免客户端继续发送此请求。 　　如果这个状况是临时的，服务器应当返回一个 Retry-After 的响应头，以告知客户端可以在多少时间以后重新尝试。 |
| 414 | 请求的URI 长度超过了服务器能够解释的长度，因此服务器拒绝对该请求提供服务。这比较少见，通常的情况包括： 　　本应使用POST方法的表单提交变成了GET方法，导致查询字符串（Query String）过长。 　　重定向URI “黑洞”，例如每次重定向把旧的 URI 作为新的 URI 的一部分，导致在若干次重定向后 URI 超长。 　　客户端正在尝试利用某些服务器中存在的安全漏洞攻击服务器。这类服务器使用固定长度的缓冲读取或操作请求的 URI，当 GET 后的参数超过某个数值后，可能会产生缓冲区溢出，导致任意代码被执行[1]。没有此类漏洞的服务器，应当返回414状态码。 |
| 415 | 对于当前请求的方法和所请求的资源，请求中提交的实体并不是服务器中所支持的格式，因此请求被拒绝。 |
| 416 | 如果请求中包含了 Range 请求头，并且 Range 中指定的任何数据范围都与当前资源的可用范围不重合，同时请求中又没有定义 If-Range 请求头，那么服务器就应当返回416状态码。 　　假如 Range 使用的是字节范围，那么这种情况就是指请求指定的所有数据范围的首字节位置都超过了当前资源的长度。服务器也应当在返回416状态码的同时，包含一个 Content-Range 实体头，用以指明当前资源的长度。这个响应也被禁止使用 multipart/byteranges 作为其 Content-Type。 |
| 417 | 在请求头 Expect 中指定的预期内容无法被服务器满足，或者这个服务器是一个代理服务器，它有明显的证据证明在当前路由的下一个节点上，Expect 的内容无法被满足。 |
| 421 | 从当前客户端所在的IP地址到服务器的连接数超过了服务器许可的最大范围。通常，这里的IP地址指的是从服务器上看到的客户端地址（比如用户的网关或者代理服务器地址）。在这种情况下，连接数的计算可能涉及到不止一个终端用户。 |
| 422 | 从当前客户端所在的IP地址到服务器的连接数超过了服务器许可的最大范围。通常，这里的IP地址指的是从服务器上看到的客户端地址（比如用户的网关或者代理服务器地址）。在这种情况下，连接数的计算可能涉及到不止一个终端用户。 |
| 422 | 请求格式正确，但是由于含有语义错误，无法响应。（RFC 4918 WebDAV）423 Locked 　　当前资源被锁定。（RFC 4918 WebDAV） |
| 424 | 由于之前的某个请求发生的错误，导致当前请求失败，例如 PROPPATCH。（RFC 4918 WebDAV） |
| 425 | 在WebDav Advanced Collections 草案中定义，但是未出现在《WebDAV 顺序集协议》（RFC 3658）中。 |
| 426 | 客户端应当切换到TLS/1.0。（RFC 2817） |
| 449 | 由微软扩展，代表请求应当在执行完适当的操作后进行重试。 |
| 500 | 服务器遇到了一个未曾预料的状况，导致了它无法完成对请求的处理。一般来说，这个问题都会在服务器的程序码出错时出现。 |
| 501 | 服务器不支持当前请求所需要的某个功能。当服务器无法识别请求的方法，并且无法支持其对任何资源的请求。 |
| 502 | 作为网关或者代理工作的服务器尝试执行请求时，从上游服务器接收到无效的响应。 |
| 503 | 由于临时的服务器维护或者过载，服务器当前无法处理请求。这个状况是临时的，并且将在一段时间以后恢复。如果能够预计延迟时间，那么响应中可以包含一个 Retry-After 头用以标明这个延迟时间。如果没有给出这个 Retry-After 信息，那么客户端应当以处理500响应的方式处理它。 　　注意：503状态码的存在并不意味着服务器在过载的时候必须使用它。某些服务器只不过是希望拒绝客户端的连接。 |
| 504 | 作为网关或者代理工作的服务器尝试执行请求时，未能及时从上游服务器（URI标识出的服务器，例如HTTP、FTP、LDAP）或者辅助服务器（例如DNS）收到响应。 　　注意：某些代理服务器在DNS查询超时时会返回400或者500错误 |
| 505 | 服务器不支持，或者拒绝支持在请求中使用的 HTTP 版本。这暗示着服务器不能或不愿使用与客户端相同的版本。响应中应当包含一个描述了为何版本不被支持以及服务器支持哪些协议的实体。 |
| 506 | 由《透明内容协商协议》（RFC 2295）扩展，代表服务器存在内部配置错误：被请求的协商变元资源被配置为在透明内容协商中使用自己，因此在一个协商处理中不是一个合适的重点。 |
|  507 | 服务器无法存储完成请求所必须的内容。这个状况被认为是临时的。WebDAV (RFC 4918)  |
| 509 | 服务器达到带宽限制。这不是一个官方的状态码，但是仍被广泛使用。 |
| 510 | 获取资源所需要的策略并没有没满足。（RFC 2774） |

## HTTP content-type
Content-Type，内容类型，一般是指网页中存在的Content-Type，用于定义网络文件的类型和网页的编码，决定浏览器将以什么形式、什么编码读取这个文件，这就是经常看到一些Asp网页点击的结果却是下载到的一个文件或一张图片的原因。

### HTTP content-type 对照表

| 文件扩展名 | Content-Type(Mime-Type) | 文件扩展名 | Content-Type(Mime-Type) |
| :------: | :---------------------: | :-------: | :---------------------: |
| .*（ 二进制流，不知道下载文件类型） | application/octet-stream	| .tif | image/tiff
| .001 | application/x-001	| .301 | application/x-301
| .323 | text/h323	| .906 | application/x-906
| .907 | drawing/907	| .a11 | application/x-a11
| .acp | audio/x-mei-aac	| .ai | application/postscript
| .aif | audio/aiff	| .aifc | audio/aiff
| .aiff | audio/aiff	| .anv | application/x-anv
| .asa | text/asa	| .asf | video/x-ms-asf
| .asp | text/asp	| .asx | video/x-ms-asf
| .au | audio/basic	| .avi | video/avi
| .awf | application/vnd.adobe.workflow	| .biz | text/xml
| .bmp | application/x-bmp	| .bot | application/x-bot
| .c4t | application/x-c4t	| .c90 | application/x-c90
| .cal | application/x-cals	| .cat | application/vnd.ms-pki.seccat
| .cdf | application/x-netcdf	| .cdr | application/x-cdr
| .cel | application/x-cel	| .cer | application/x-x509-ca-cert
| .cg4 | application/x-g4	| .cgm | application/x-cgm
| .cit |	application/x-cit	| .class | java/*
| .cml | text/xml	| .cmp | application/x-cmp
| .cmx | application/x-cmx	| .cot | application/x-cot
| .crl | 	application/pkix-crl	| .crt | application/x-x509-ca-cert
| .csi | application/x-csi	| .css | text/css
| .cut | application/x-cut	| .dbf | application/x-dbf
| .dbm | application/x-dbm	| .dbx | application/x-dbx
| .dcd | text/xml	| .dcx | application/x-dcx
| .der | application/x-x509-ca-cert	| .dgn | application/x-dgn
| .dib | application/x-dib	| .dll | application/x-msdownload
| .doc | application/msword	| .dot | application/msword
| .drw | application/x-drw	| .dtd | text/xml
| .dwf | Model/vnd.dwf	 | .dwf | application/x-dwf
| .dwg | application/x-dwg	| .dxb | application/x-dxb
| .dxf | application/x-dxf	| .edn | application/vnd.adobe.edn
| .emf | application/x-emf	| .eml | message/rfc822
| .ent | text/xml	| .epi | application/x-epi
| .eps | application/x-ps	| .eps | application/postscript
| .etd | application/x-ebx	| .exe | application/x-msdownload
| .fax | image/fax	| .fdf | application/vnd.fdf
| .fif | application/fractals	| .fo | text/xml
| .frm | application/x-frm	| .g4 | application/x-g4
| .gbr | application/x-gbr	| . | application/x-
| .gif | image/gif	| .gl2 | 	application/x-gl2
| .gp4 | application/x-gp4	| .hgl | application/x-hgl
| .hmr | application/x-hmr	| .hpg | application/x-hpgl
| .hpl | application/x-hpl	| .hqx | application/mac-binhex40
| .hrf | application/x-hrf	| .hta | application/hta
| .htc | text/x-component	| .htm | text/html
| .html | text/html	| .htt | text/webviewhtml
| .htx | text/html	| .icb | application/x-icb
| .ico | image/x-icon	| .ico | application/x-ico
| .iff | application/x-iff	| .ig4 | application/x-g4
| .igs | application/x-igs	| .iii | application/x-iphone
| .img | application/x-img	| .ins | application/x-internet-signup
| .isp | application/x-internet-signup	| .IVF | video/x-ivf
| .java | java/*	| .jfif | image/jpeg
| .jpe | image/jpeg	| .jpe | application/x-jpe
| .jpeg | image/jpeg	| .jpg | image/jpeg
| .jpg | application/x-jpg	| .js | application/x-javascript
| .jsp | text/html | .la1 | audio/x-liquid-file
| .lar | application/x-laplayer-reg	| .latex  | 	application/x-latex
| .lavs | audio/x-liquid-secure	| .lbm | application/x-lbm
| .lmsff | audio/x-la-lms	| .ls | application/x-javascript
| .ltr | application/x-ltr	| .m1v | video/x-mpeg
| .m2v | video/x-mpeg	| .m3u | audio/mpegurl
| .m4e | video/mpeg4	| .mac | application/x-mac
| .man | application/x-troff-man	| .math | text/xml
| .mdb | application/msaccess	| .mdb | application/x-mdb
| .mfp | application/x-shockwave-flash	| .mht | message/rfc822
| .mhtml | message/rfc822	| .mi | application/x-mi
| .mid | audio/mid	| .midi | audio/mid
| .mil | application/x-mil	| .mml	 | /xml
| .mnd | audio/x-musicnet-download	| .mns | audio/x-musicnet-stream
| .mocha | application/x-javascript	| .movie | video/x-sgi-movie
| .mp1 | audio/mp1	| .mp2 | audio/mp2
| .mp2v | video/mpeg	| .mp3 | audio/mp3
| .mp4 | video/mpeg4	| .mpa | video/x-mpg
| .mpd | application/vnd.ms-project	| .mpe | video/x-mpeg
| .mpeg | video/mpg	| .mpg | video/mpg
| .mpga | audio/rn-mpeg	 | .mpp | application/vnd.ms-project
| .mps | video/x-mpeg	| .mpt | application/vnd.ms-project
| .mpv | video/mpg	| .mpv2 | video/mpeg
| .mpw | application/vnd.ms-project	| .mpx | application/vnd.ms-project
| .mtx | text/xml	| .mxp | application/x-mmxp
| .net | image/pnetvue 	| .nrf | application/x-nrf
| .nws | message/rfc822	| .odc | text/x-ms-odc
| .out | application/x-out	| .p10 | application/pkcs10
| .p12 | application/x-pkcs12	| .p7b | application/x-pkcs7-certificates
| .p7c | application/pkcs7-mime	| .p7m | application/pkcs7-mime
| .p7r | application/x-pkcs7-certreqresp	| .p7s | application/pkcs7-signature
| .pc5 | application/x-pc5	| .pci | application/x-pci
| .pcl | application/x-pcl	| .pcx | application/x-pcx
| .pdf | application/pdf	| .pdf | application/pdf
| .pdx | application/vnd.adobe.pdx	| .pfx | application/x-pkcs12
| .pgl | application/x-pgl	| .pic | application/x-pic
| .pko | application/vnd.ms-pki | .pko	.pl | application/x-perl
| .plg | text/html	 | .pls | audio/scpls
| .plt | application/x-plt	| .png | image/png
| .png | application/x-png	| .pot | application/vnd.ms-powerpoint
| .ppa | application/vnd.ms-powerpoint	| .ppm | application/x-ppm
| .pps | application/vnd.ms-powerpoint	| .ppt | application/vnd.ms-powerpoint
| .ppt | application/x-ppt	| .pr | application/x-pr
| .prf | application/pics-rules	| .prn | application/x-prn
| .prt | application/x-prt	| .ps | application/x-ps
| .ps | application/postscript	| .ptn | application/x-ptn
| .pwz | application/vnd.ms-powerpoint	| .r3t | text/vnd.rn-realtext3d
| .ra | audio/vnd.rn-realaudio	| .ram | audio/x-pn-realaudio
| .ras | application/x-ras	| .rat | application/rat-file
| .rdf | text/xml	| .rec | application/vnd.rn-recording
| .red | application/x-red	| .rgb | application/x-rgb
| .rjs | application/vnd.rn-realsystem-rjs	 | .rjt | application/vnd.rn-realsystem-rjt
| .rlc | application/x-rlc	| .rle | application/x-rle
| .rm | application/vnd.rn-realmedia	| .rmf | application/vnd.adobe.rmf
| .rmi | audio/mid	| .rmj | application/vnd.rn-realsystem-rmj
| .rmm | audio/x-pn-realaudio	| .rmp | application/vnd.rn-rn_music_package
| .rms | application/vnd.rn-realmedia-secure	| .rmvb | application/vnd.rn-realmedia-vbr
| .rmx | application/vnd.rn-realsystem-rmx | .rnx | application/vnd.rn-realplayer
| .rp | image/vnd.rn-realpix	| .rpm | audio/x-pn-realaudio-plugin
| .rsml | application/vnd.rn-rsml	 | .rt | text/vnd.rn-realtext
| .rtf | application/msword	| .rtf | application/x-rtf
| .rv | video/vnd.rn-realvideo	| .sam | application/x-sam
| .sat | application/x-sat	| .sdp | application/sdp
| .sdw | application/x-sdw	| .sit | application/x-stuffit
| .slb | application/x-slb	| .sld | application/x-sld
| .slk | drawing/x-slk	 | .smi | application/smil
| .smil | application/smil	 | .smk | application/x-smk
| .snd | audio/basic	| .sol | text/plain
| .sor | text/plain	| .spc | application/x-pkcs7-certificates
| .spl | application/futuresplash	| .spp | text/xml
| .ssm | application/streamingmedia	 | .sst | application/vnd.ms-pki.certstore
| .stl | application/vnd.ms-pki.stl	 | .stm | text/html
| .sty | application/x-sty	| .svg | text/xml
| .swf | application/x-shockwave-flash	 | .tdf | application/x-tdf
| .tg4 | application/x-tg4	| .tga | application/x-tga
| .tif | image/tiff	| .tif | application/x-tif
| .tiff | image/tiff	| .tld | text/xml
| .top | 	drawing/x-top	 | .torrent | application/x-bittorrent
| .tsd | text/xml	| .txt | text/plain
| .uin | application/x-icq	| .uls | text/iuls
| .vcf | text/x-vcard	| .vda | application/x-vda
| .vdx | application/vnd.visio	| .vml | text/xml
| .vpg | application/x-vpeg005	| .vsd | application/vnd.visio
| .vsd | application/x-vsd	| .vss | application/vnd.visio
| .vst | application/vnd.visio	| .vst | application/x-vst
| .vsw | application/vnd.visio	| .vsx | application/vnd.visio
| .vtx | application/vnd.visio	| .vxml | text/xml
| .wav | audio/wav	| .wax | audio/x-ms-wax
| .wb1 | application/x-wb1	| .wb2 | application/x-wb2
| .wb3 | application/x-wb3	| .wbmp | image/vnd.wap.wbmp
| .wiz | application/msword	| .wk3 | application/x-wk3
| .wk4 | application/x-wk4	| .wkq | application/x-wkq
| .wks | application/x-wks	| .wm | video/x-ms-wm
| .wma | audio/x-ms-wma	| .wmd | application/x-ms-wmd
| .wmf | application/x-wmf	| .wml | text/vnd.wap.wml
| .wmv | video/x-ms-wmv	| .wmx | video/x-ms-wmx
| .wmz | application/x-ms-wmz	| .wp6 | application/x-wp6
| .wpd | application/x-wpd	| .wpg | application/x-wpg
| .wpl | application/vnd.ms-wpl	| .wq1 | application/x-wq1
| .wr1 | application/x-wr1	| .wri | application/x-wri
| .wrk | application/x-wrk	| .ws | application/x-ws
| .ws2 | application/x-ws	| .wsc | text/scriptlet
| .wsdl | text/xml	| .wvx | video/x-ms-wvx
| .xdp | application/vnd.adobe.xdp	| .xdr | text/xml
| .xfd | application/vnd.adobe.xfd	| .xfdf | application/vnd.adobe.xfdf
| .xhtml | text/html	| .xls | application/vnd.ms-excel
| .xls | application/x-xls	| .xlw | application/x-xlw
| .xml | text/xml	| .xpl | audio/scpls
| .xq | text/xml	| .xql | text/xml
| .xquery | text/xml	| .xsd | text/xml
| .xsl | text/xml	| .xslt | text/xml
| .xwd | application/x-xwd	| .x_b | application/x-x_b
| .sis | application/vnd.symbian.install	| .sisx | application/vnd.symbian | .install
| .x_t | application/x-x_t	| .ipa | application/vnd.iphone
| .apk | application/vnd.android.package-archive	| .xap | application/x-silverlight-app

## HTTP消息结构
HTTP是基于客户端/服务端（C/S）的架构模型，通过一个可靠的链接来交换信息，是一个无状态的请求/响应协议。  
一个HTTP"客户端"是一个应用程序（Web浏览器或其他任何客户端），通过连接到服务器达到向服务器发送一个或多个HTTP的请求的目的。  
一个HTTP"服务器"同样也是一个应用程序（通常是一个Web服务，如Apache Web服务器或IIS服务器等），通过接收客户端的请求并向客户端发送HTTP响应数据。  
HTTP使用统一资源标识符（Uniform Resource Identifiers, URI）来传输数据和建立连接。

一旦建立连接后，数据消息就通过类似Internet邮件所使用的格式[RFC5322]和多用途Internet邮件扩展（MIME）[RFC2045]来传送。

### HTTP请求报文
一个HTTP请求报文由四个部分组成：请求行、请求头、空行、请求体。

1. 请求行

	由请求方法字段、URL字段和HTTP协议版本字段3个字段组成，它们用空格分隔。比如 GET /data/info.html HTTP/1.1。

	方法字段就是HTTP使用的请求方法，比如常见的GET/POST。
	
	其中HTTP协议版本有两种：HTTP1.0/HTTP1.1可以这样区别：
	* HTTP1.0对于每个连接都的建立一次连接，一次只能传送一个请求和响应，请求完成就会关闭，HTTP1.0没有Host字段；
	* HTTP1.1在同一个连接中可以传送多个请求和响应，多个请求可以重叠和同时进行，HTTP1.1必须有Host字段。

2. 请求头

	以 字段名：值 的格式展现。

	用于HTTP请求中的常用请求头字段：
	* Accept：用于高速服务器，客户机支持的数据类型
	* Accept-Charset：用于告诉服务器，客户机采用的编码格式
	* Accept-Encoding：用于告诉服务器，客户机支持的数据压缩格式
	* Accept-Language：客户机的语言环境
	* Host：客户机通过这个头告诉服务器，想访问的主机名
	* If-Modified-Since：客户机通过这个头告诉服务器，资源的缓存时间
	* Referer：客户机通过这个头告诉服务器，它是从哪个资源来访问服务器的（防盗链）
	* User-Agent：客户机通过这个头告诉服务器，客户机的软件环境
	* Cookie：客户机通过这个头可以向服务器带数据
	* Connection：处理完这次请求后是否断开连接还是继续保持连接
	* Date：当前时间值

3. 空行

	空行的表现形式很直接，就是一个空行，它的作用是通过一个空行，告诉服务器请求头部到此为止。
	
4. 请求体

	若方法字段是GET，则此项为空，没有数据。若方法字段是POST，则通常来说此处放置的就是要提交的数据。

	比如要使用POST方法提交一个表单，其中有name字段中数据为“xiaoming"，age字段为17，那么这里的请求数据就是name=xiaoming&age=17，使用&来连接各个字段。

上面是GET方法，参数直接置于请求行URL中，请求体为空；POST方法请求行URL段中一般是没有参数的，参数放在了请求体中。

### HTTP响应报文
HTTP响应报文也由四部分组成：响应行、响应头、空行、响应体。

1. 响应行
	
	一般由协议版本、状态码及其描述组成。比如：HTTP/1.1 200 OK

	其中协议版本HTTP/1.1，或者HTTP/1.0；200就是它的状态码，OK则为它的描述。

2. 响应头

	通常也是由 字段名：值  组成。

	响应头用于描述服务器的基本信息，以及数据的描述，服务器通过这些数据的描述信息，可以通知客户端如何处理等一会儿它回送的数据。

	常见的响应头字段：
	
	* Location：　　　　     这个头配合302状态码使用，用于告诉客户找谁。
	* Server：　　　　　     服务器通过这个头告诉浏览器服务器的类型。
	* Content-Encoding：　服务器通过这个头告诉浏览器数据的压缩格式。
	* Content-Length：　　服务器通过这个头告诉浏览器回送数据的长度
	* Content-Type：   　　服务器通过这个头告诉浏览器回送数据的类型
	* Last-Modified：   　　告诉浏览器当前资源的最后缓存时间
	* Refresh：　　　　      告诉浏览器隔多久刷新一次
	* Content-Disposition：告诉浏览器以下载方式打开数据
	* Transfer-Encoding：  告诉浏览器数据的传送格式
	* ETag：      　　　  　  缓存相关的头
	
	其中三种禁止浏览器缓存的头字段：
	
 	* Expires：告诉浏览器把回送的资源缓存多长时间 -1或0则是不缓存
 	* Cache-Control：no-cache
 	* Pragma：no-cache
 	
 	服务器通过以上两个头，也就是控制浏览器不要缓存数据

3. 空行

	空行的表现形式很直接，就是一个空行，它的作用是通过一个空行，告诉服务器响应头部到此为止。
	
4. 响应体
	
	里面放置的就是服务器返回的数据，可以设置返回的格式为JSON或者HTML。