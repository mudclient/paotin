# PaoTin++

这是一个基于 [TinTin++](https://github.com/scandum/tintin) 的定制发行版。包括一些尚未被合并进官方 TinTin++ 版本的 patch 和一些基础性的框架代码，企图能够对 TinTin++ 的功能有所增强。

# 运行方式

## 本地运行

### 使用本地 tt++ （需要自行编译 tintin++）

如果你本地已经编译好了 tt++，那么输入以下命令就可以立即开始游戏：

```
./setup
start-ui
```

### 使用本仓库推荐的 tt++（推荐）

假设你本地已经有完整的 C 语言开发环境，那么用下面的命令就可以自行编译 tt++：

```
git clone https://github.com/mudclient/tintin.git --branch beta-develop
(cd tintin/src && ./configure && make && strip tt++)
cp tintin/src/tt++ bin/
mkdir -p log
./setup
start-ui
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
# 创建游戏主目录，该目录可以自定义
mkdir -p $HOME/my-paotin/

# 创建游戏目录结构
mkdir -p $HOME/my-paotin/{ids,etc,log,plugins}

docker run -d -it --name tt --hostname tt -v $HOME/my-paotin:/paotin/var mudclient/paotin daemon
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

# 开发自己的插件

## Docker 方式下

Docker 方式下，可以将本地工作目录 mount 到容器内的 /paotin/var 目录，那么就可以实现容器内外的文件共享。

```
mkdir -p $HOME/my-paotin   # 先创建一个本地工作目录
docker run -d -it --name tt --hostname tt -v $HOME/my-paotin:/paotin/var mudclient/paotin daemon
```

如果你编辑本地工作目录（上面假设为 `$HOME/my-paotin`）中的文件，那么 Docker 内部是可以访问到的。
如果你将自己的插件放置在 `$HOME/my-paotin/plugins/` 目录下，那么 Docker 内部可以正常加载。

另外，日志文件会出现在 `$HOME/my-paotin/log/` 目录下，
ID 配置文件和数据配置文件可分别放置在 `$HOME/my-paotin/ids/` 目录和 `$HOME/my-paotin/etc/` 目录下。

更多内容请参见 `DIRECTORY.md` 文件。

## 本地运行方式

你可以在 `plugins/` 目录下编写你的插件。插件代码格式可参考样板插件 `plugins/EXAMPLE.tin` 及其它已有插件。

# 特性介绍

## 实用命令

大部分自定义功能都采用 TinTin++ 的别名来实现，也有一部分是函数。考虑到命令行下也有手动输入的需要，
因此部分别名有长名称和短名称两个版本。长名称用来在代码中使用以增加可读性。短名称在命令行下则可以简化输入。

### 模块管理

* `load-module` （短名称 `LM`），可以加载模块。例如 `load-module foo` 或者 `LM foo`（下面不再为短名称单独举例）。

PaoTin++ 下的模块分「弱模块」、「纯模块」与「混合模块」三类。对纯模块和混合模块而言，`load-module` 还可以在加载时提供配置参数。例如：

```
load-module fullskill {
    {eat}       {gan liang}
    {drink}     {niurou tang}
    {sleep}     {e;e;sleep}
    {wakeup}    {w;w;lian sword 10}
};
```

相信不难看出这是一个名叫 `fullskill` 的练功模块，渴了就喝牛肉汤，饿了就吃干粮，睡觉去东边，醒来了去西边。
通过这种方式可以提高模块的通用性。

* `kill-module` （短名称 `KM`），用来卸载模块。例如 `kill-module foo`。
* `reload-module` （短名称 `RLM`），重新载入模块。例如 `reload-module foo`。
* `disable-module` （短名称 `DM`），禁用已加载的模块。例如 `disable-module foo`。模块被禁用之后，就像是尚未被加载一样，不会影响游戏的其它部分。
* `enable-module`（短名称 `EM`），重新启用已加载但被禁用的模块。例如 `enable-moudle foo`。
* `list-modules`（短名称 `MODS`），查看所有已加载的模块清单。该命令无参数。
* `look-module`（短名称 `MOD`），查看指定模块的详细说明。例如 `look-module foo`。
* `load-lib`（短名称 `LL`），加载 library。例如 `load-lib event`，相当于 `load-module lib/event`。library 是一类更加基础的插件模块。一般在代码中使用 `load-lib` 来加载本模块所依赖的 library。
