# PaoTin++

这是一个基于 [TinTin++](https://github.com/scandum/tintin) 的定制发行版。包括一些尚未被合并进官方 TinTin++ 版本的 patch 和一些基础性的框架代码，企图能够对 TinTin++ 的功能有所增强。

# 运行方式

## 本地运行

### 使用本地 tt++ （需要自行编译 tintin++）

如果你本地已经编译好了 tt++，那么输入以下命令就可以立即开始游戏：

```
bin/start-ui
```

### 使用本仓库推荐的 tt++（推荐）

假设你本地已经有完整的 C 语言开发环境，那么用下面的命令就可以自行编译 tt++：

```
git clone https://github.com/mudclient/tintin.git --branch beta-develop
(cd tintin/src && ./configure && make && strip tt++)
cp tintin/src/tt++ bin/
export PATH=$PATH:$(pwd)/bin
mkdir -p log
bin/start-ui
```

## Docker 方式运行（推荐）

### 已发布的 Docker 镜像

如果你本地已经安装好了 Docker 环境，使用下面命令就可以立即开始游戏：

```
docker run --rm -it --name tt --hostname tt mudclient/paotin
```

上面的命令会自动下载 Docker 镜像，创建 Docker 容器，然后启动游戏界面，开始体验。

如果一切正常，你将会看到一个带有蓝色状态栏的 tmux 界面。和一个简单的游戏指引。

如果想要结束体验，可以按 `<ctrl+a> d` 组合键，就会退出游戏，并自动删除刚刚创建的 Docker 容器。

如果你想要长期挂机，则要使用下面的命令：

```
docker run -d -it --name tt --hostname tt mudclient/paotin daemon
```

以后每次上线的时候，只需要用下面的命令就可以连接到 UI：

```
docker exec -it tt start-ui
```

同样可以用 `<ctrl+a> d` 组合键退出游戏。但这并不会终止 TinTin++ 进程，下次用上面的命令可以继续游戏。

### 自行构建 Docker 镜像

你也可以在本地构建 Docker 镜像，并通过下面的命令使用自己构建的镜像开始游戏：

```
# 构建 Docker 镜像
docker build -t paotin .

# 开始游戏
docker run --rm -it --name tt --hostname tt paotin
```
