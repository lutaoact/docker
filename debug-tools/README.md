# debug-tools

* 使用方法

```
make run c=[container name or id]
```

* 原理

命令会启动一个旁路容器，和原容器共享pid和network namespace，可以通过`ps aux`命令查看进程，也可以直接进入相关进程的文件系统，路径为`/proc/[pid]/root`。

容器内置了一些调试工具，包括`telnet, wget, curl, netstat, strace`等工具，有其它需求，也可以直接提pr。
