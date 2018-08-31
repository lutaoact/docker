# debug-tools

## 使用方法

```bash
# 在项目目录中执行：
make run c=[container name or id]
```

或者

```bash
docker run -it --rm --pid=container:[c] --net=container:[c] --cap-add all reg.qiniu.com/lutaoact/debug-tools
# c表示容器名称或id
```

或者将命令定义为函数，添加到~/.bashrc，简化使用方式：

```
function cdebug() {
  if [ -z "$1" ]; then
    docker run -it --rm -v /tmp:/tmp reg.qiniu.com/lutaoact/debug-tools
  else
    docker run -it --rm -v /tmp:/tmp --pid=container:"$1" --net=container:"$1" --cap-add all reg.qiniu.com/lutaoact/debug-tools
  fi
}

cdebug [container name or id]
```

## 原理

命令会启动一个旁路容器，和原容器共享pid和network namespace，可以通过`ps aux`命令查看进程，也可以直接进入相关进程的文件系统，路径为`/proc/[pid]/root`。

容器内置了一些调试工具，包括`telnet, wget, curl, netstat, strace`等工具，有其它需求，也可以直接提pr。

## 相关链接

* [How-to Debug a Running Docker Container from a Separate Container](https://medium.com/@rothgar/how-to-debug-a-running-docker-container-from-a-separate-container-983f11740dc6)
* [enter for debug](https://gist.github.com/justincormack/f2444fbdf210b05d4f7baabe6fcd219a)
