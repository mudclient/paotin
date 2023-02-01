<p align="center">
    <h3 align="center">PaoTin++</h3>
    <p align="center">TinTin++ 脚手架，一个更好的 TinTin++ 编程环境</p>
    <p align="center">
        <a href="#软件结构及亮点功能">亮点功能</a> •
        <a href="#docker-方式运行推荐">在 Docker 上运行</a> •
        <a href="#本地运行">在本机环境下安装与运行</a> •
        <a href="#特性介绍">特性介绍</a>
    </p>
</p>

# PaoTin++ 是什么？不是什么？

这是一个基于 [TinTin++](https://github.com/scandum/tintin) 的定制发行版。包括一些尚未被合并进官方 TinTin++ 版本的 patch 和一些基础性的框架代码，企图能够对 TinTin++ 的功能有所增强。

PaoTin++ 主要目的是整理并输出本人过去在使用 TinTin++ 时，为了解决一些实践中遇到的困难而设计的解决方案。
这些解决方案大体分两部分，一部分是对 TinTin++ 自身源码的修改，数量不多，但可以从源头上弥补 TinTin++ 的一些不足。
另一部分是一组纯 TinTin++ 脚本，目的是为了构建一个更好的编写 TinTin++ 脚本的框架平台。

对于一部分人来说，可以把 PaoTin++ 当成是一个集成的一体化的 TinTin++ 游戏与开发环境。在该环境下，相较于原版 TinTin++，PaoTin++ 提供了一些额外的功能。

对于另一部分人来说，可以把 PaoTin++ 当成是了解、学习 TinTin++ 脚本的参考示例。特别是如何在 TinTin++ 环境下构造复杂的脚本框架，本仓库做了一些积极的尝试。

PaoTin++ 不是一个成熟的机器人套件，并不计划提供一整套开箱即用的，可以无人值守方式挂机的机器人脚本。虽然这可能是许多玩家所渴望的，但由于每个人的游戏目标不同，以及游戏内可能存在的玩家竞争机制，因此我不认为复制别人的游戏策略是明智的选择。但玩家可以基于 PaoTin++ 开发自己的机器人。或是在使用 TinTin++ 开发机器人的过程中，如果遇到了 PaoTin++ 已经解决过的困难，那么不妨试试 PaoTin++。

# 软件结构及亮点功能

PaoTin++ 技术架构图：

![PaoTin++ schema](https://user-images.githubusercontent.com/15100900/203256221-3bebce64-7376-4f30-8940-e3e149ba6720.jpg)

PaoTin++ 主要由以下四部分组成：

* 一个 [TinTin++ 衍生品](https://github.com/mudclient/tintin/tree/beta-develop)，它在 TinTin++ beta 版的基础上，
  提供了一些额外的[补丁](https://github.com/mudclient/tintin/compare/beta...mudclient:tintin:beta-develop)。
* 一个由 TinTin++ 脚本书写的[框架程序](https://github.com/mudclient/paotin/tree/master/framework)，
  其主要部分包含一个[模块加载器](https://github.com/mudclient/paotin#模块管理)。
* 一组由 TinTin++ 脚本书写的 [TinTin++ 功能扩展](https://github.com/mudclient/paotin/tree/master/plugins/lib)。
* 预置的与特定 MUDLIB [有关的触发](https://github.com/mudclient/paotin/tree/master/mud)。

亮点功能：

* ✅同步发布 Docker 镜像
* ✅模块化编程框架
* ✅支持模块源码重定位
* ✅支持多 MUDLIB
* ✅完善的日志记录
* ✅事件驱动编程框架
* ✅防掉线机制
* ✅输入回显与命令回显
* ✅命令行自动补全
* ✅基于 tmux 的 UI 设计，可以灵活定制 tmux pane border
* ✅可自定义的提示栏
* ✅utf-8 支持与界面美化
* ✅鼠标支持，支持快捷键和鼠标翻页、查询屏幕内容
* ✅PCRE 支持 utf-8 字符类
* ✅更好的颜色泄漏防范
* ✅支持 GMCP
* ✅支持 MXP
* ✅支持 MSLP

# 运行方式

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
mkdir -p $HOME/my-paotin/{ids,etc,data,log,plugins}

docker run -d -it --name tt --hostname tt -v $HOME/my-paotin:/paotin/var mudclient/paotin daemon
```

以后每次上线的时候，只需要用下面的命令就可以连接到 UI：

```
docker exec -it tt start-ui
```

同样可以用 `<ctrl+a> d` 组合键退出游戏。但这并不会终止 TinTin++ 进程，下次用上面的命令可以继续游戏。

### 自行构建 Docker 镜像

你也可以基于本仓库在本地构建 Docker 镜像，并通过下面的命令使用自己构建的镜像开始游戏：

```
# 构建 Docker 镜像
docker build -t paotin .

# 开始游戏
docker run --rm -it --name tt --hostname tt paotin
```

## 本地运行

### 准备编译环境

#### macOS

```
brew install gcc make gnutls pcre zlib git bash tmux
```

#### Ubuntu

```
sudo apt-get install build-essential zlib1g-dev libpcre3-dev libgnutls28-dev git bash tmux
```

#### Fedora

```
sudo yum install make gcc zlib-devel pcre-devel git bash tmux
```

#### Debian

```
sudo apt-get install build-essential zlib1g-dev libpcre++-dev git bash tmux
```

#### Android(Termux)

```
apt install make libgnutls pcre zlib git bash tmux
```

#### 其它类 Unix 系统

请自行安装：

* C 语言编译器
* make 实用程序
* pcre 开发包
* zlib 开发包
* git
* bash
* tmux

### 编译本仓库指定的 TinTin++（推荐）

假设你是首次使用 PaoTin++，那么你需要先编译一份 PaoTin++ 依赖的 TinTin++，
假设你本机已经有完整的 C 语言开发环境，那么用下面的命令就可以开始编译：

```
git clone https://github.com/mudclient/paotin.git
cd paotin
./install
```

编译完成后，使用下面的命令即可开始游戏：

```
./paotin-start
```

以后每次更新 PaoTin++ 时，如果涉及到 TinTin++ 的更新，则需要重新执行 `./install`，
否则每次执行 `./paotin-start` 即可进入环境。

### 自行选择并编译 TinTin++

如果你比较熟悉 TinTin++，知道 PaoTin++ 依赖的 fork 需要哪些特性，你也可以根据自己的需求来选择并编译 TinTin++。
只需要将你编译好的 `tt++` 可执行文件链接或者复制到 PaoTin++ 的 `bin` 目录，就可以直接通过下面的命令来进入环境：

```
git clone https://github.com/mudclient/paotin.git
cd paotin
# TODO: 这里需要你自己把你编译的 tt++ 文件放入 bin/ 目录。
# 然后执行
./paotin-start
```

# 定制与开发

无论是 Docker 运行方式，还是本地运行方式，都不建议直接修改仓库内已有的文件和目录，以免后续更新时造成冲突。
PaoTin++ 大部分模块源码文件都支持重定位，你可以在 `var/` 目录下创建自己的新插件或者重写已有插件。

## Docker 方式下

Docker 方式下，可以将本地工作目录 mount 到容器内的 /paotin/var 目录，那么就可以实现容器内外的文件共享。

```
# 先创建一个本地工作目录
mkdir -p $HOME/my-paotin/{ids,etc,data,log,plugins}
docker run -d -it --name tt --hostname tt -v $HOME/my-paotin:/paotin/var mudclient/paotin daemon
```

如果你编辑本地工作目录（上面假设为 `$HOME/my-paotin`）中的文件，那么 Docker 内部是可以访问到的。
如果你将自己的插件放置在 `$HOME/my-paotin/plugins/` 目录下，那么 Docker 内部可以正常加载。

另外，日志文件会出现在 `$HOME/my-paotin/log/` 目录下，
ID 配置文件和数据配置文件可分别放置在 `$HOME/my-paotin/ids/` 目录和 `$HOME/my-paotin/etc/` 目录下。

更多内容请参见 `docs/DIRECTORY.md` 文件。

## 本地运行方式

你可以在 `var/plugins/` 目录下编写你的插件。插件代码格式可参考样板插件 `plugins/EXAMPLE.tin` 及其它已有插件。

建议另外新建一个目录，用来存放你的源代码，并将 `var/` 目录通过符号链接指向该目录。例如：

```
mkdir -p ../my-paotin/{ids,etc,data,log,plugins}
ln -s ../my-paotin var
```

这样的话修改 `var/*` 就不会影响 PaoTin++ 仓库的文件，不会在 PaoTin++ 更新时造成冲突。

更多内容请参见 `docs/DIRECTORY.md` 文件。

# 特性介绍

## 屏幕美化

基本上每个刚刚接触 TinTin++ 的玩家，都会遇到 UTF-8 下字符不能对齐的问题。PaoTin++ 内置插件 `lib/ui/beautify` 很好地解决了这个问题。

如果你看到 PaoTin++ 中渲染出来的表格线或者划线明显比文字内容要短，那可能是因为 `lib/ui/beautify` 插件工作不正常导致的。这通常是因为你的 TinTin++ 版本不正确导致的。建议通过 Docker 方式运行 PaoTin++，或者采用本文档推荐的 TinTin++ 版本，就可以解决该问题。

如果你看到 PaoTin++ 中渲染出来的表格线或者划线严重超长，比一般的文字内容要长一倍，那可能是因为你的终端设置中，开启了亚洲字符双宽度显示功能导致。请检查你的终端设置，关闭该功能即可解决。

## 灵活的提示栏

PaoTin++ 内置插件 `lib/ui/prompt` 提供了一个非常灵活的提示栏界面。该插件的亮点功能有：

* 支持通过外置配置文件自定义提示栏信息，无需修改代码即可实现个性化需求
* 简便的排版布局定制
* 支持空数据自动隐藏，使得较小的屏幕可以容纳更多的信息
* 支持倒计时提示信息
* 支持信息过期自动隐藏
* 支持定制主题配色

## 事件驱动编程

PaoTin++ 内置插件 `lib/event` 提供了一个事件驱动编程框架。其 API 非常简单、易用。

* `event.Define` 声明事件，语法格式为：

```
event.Define {char/status}    {无参}  {char/status} {已经获取到 status_me 命令输出结果，并更新 char[STATUS]。};
```

四个参数分别为：

1. 事件名称
2. 事件类型，有参数的事件写「有参」，无参数的事件写「无参」。参见下方事件发射和事件订阅 API 的说明。
3. 事件所属模块，这里一般建议写发射事件一方的模块名称。
5. 事件说明。给人看的，方便用户知道你这个事件是做什么用的。

* `event.Emit` 发射事件，语法格式为：

```
#nop 对于无参数事件只需要两个参数即可;
event.Emit {char/status} {}

#nop 对于有参数事件则需要三个参数;
event.Emit {GMCP.Move} {} {$GMCP[Move]}
```

可以看到，根据事件是否携带参数，调用时所需要的参数个数也不一样。
另外，第二个参数的含义表示触发哪些事件订阅者，默认全部触发，如有必要也可以在这里写正则表达式，来触发匹配的事件订阅者。

* `event.Handle` 订阅事件，语法格式为：

```
event.Handle {char/status} {prompt} {UI} {updateHP};
```

四个参数的含义分别为：

1. 要订阅的事件名称
2. 订阅方的身份ID，可供发射方过滤选择
3. 订阅方的模块名称，给人看的，可不必十分准确
4. 事件被触发后，需要执行的代码。可以是一个别名，也可以是一个代码块。

上面表示本模块是 UI 模块，请求订阅事件 `char/status`，并且标识自己的订阅者身份ID为 `prompt`，如果事件发送者愿意，可以通过 `prompt` 来过滤并选择本次订阅。一旦事件被触发，则自动调用别名 `updateHP` 来更新 UI 显示。

对于有参数事件，第四个参数一定要用别名，事件参数会作为别名的参数传递过去。

* `event.HandleOnce` 仅订阅一次事件。类似于 `event.Handle`，不再赘述。

* `event.UnHandle` 取消订阅。语法格式为：

```
event.UnHandle {char/status} {prompt}
```

两个参数分别为事件名称和订阅者名称。

* `event.List` 查看事件系统现状。

这个命令可以用来列出所有目前已定义的事件，以及它们的订阅情况。方便用户了解系统中都有哪些事件可供订阅，以及目前的订阅关系。

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
* `load-file`，加载文件。例如 `load-file plugins/quest/foo.tin`，类似于 `#read`，但是和 `#read` 有一点不同的是，`load-file` 支持文件重定位。也就是说，如果存在 `var/plugins/quest/foo.tin`，那么将会优先加载。通过这种方式，用户可以重写 PaoTin++ 默认的插件，以修复其中的错误或者实现自定义行为。

## 命令行自动补全

PaoTin++ 中无需手动维护，基础框架会为每个符合条件的别名自动添加命令行自动补全。假设有个模块叫做 `foo`，其中有个别名叫做 `foo.Bar`，那么 `load-module foo` 之后，用户就可以在命令行通过自动补全得到 `foo.Bar` 了。具体规则为：

* 如果别名中没有小数点 `.`，那么只有第一个字母是大写字母的别名，才会自动补全。
* 如果别名中存在小数点 `.`，那么只有最后一个小数点后面的第一个字母是大写字母的别名，才会自动补全。
* 除了大小写字母、数字、连字符（即半角的减号）、小数点之外，别名中如果出现其它种类的字符，则不支持自动补全。
