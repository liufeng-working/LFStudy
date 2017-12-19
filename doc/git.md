#git学习
---

##远程仓库已存在且本地仓库也存在时，解决远程库和本地库的链接

> 方法1

```objc
1. git pull
2. git branch --set-upstream-to=origin/master master
3. git rebase origin/master
```    

> 方法2

```
git pull --rebase
```