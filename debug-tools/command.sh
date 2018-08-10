# 调用strace的权限
docker run -it --rm --pid=container:redis6379 --net=container:redis6379 --cap-add sys_admin --cap-add sys_ptrace ke-debug bash
# 赋予全部权限
docker run -it --rm --pid=container:redis6379 --net=container:redis6379 --cap-add all ke-debug bash
docker run -it --rm --pid=container:481eded47827 --net=container:481eded47827 --cap-add all ke-debug bash
