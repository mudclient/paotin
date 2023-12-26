# PaoTin++ 安装指南

## 一键式安装脚本集合

本目录下存放适用于各类用户各类平台的一键式安装脚本。

### 安卓系统

安卓系统可借助 Termux 来运行 PaoTin++，具体安装命令如下：

```
curl -sL https://github.com/mudclient/paotin/-/raw/install/termux-install | bash
```

### iOS 系统

iPhone/iPad 可借助 iSH Shell 来运行 PaoTin++，具体安装命令如下：

```
wget -qO - https://github.com/mudclient/paotin/-/raw/install/ish-install | sh
```

### Docker 系统

Docker 用户需要先建立本地存储目录，以确保 Docker 容器里的修改能够持久化存储。

```
mkdir $HOME/my-paotin
docker run -d -it --name tt --hostname tt -v $HOME/my-paotin:/paotin/var mudclient/paotin daemon
```

### macOS、Linux 和 BSD 系统

这些系统上的安装方法基本相同，由于编译 TinTin++ 需要 C 编译环境和少量依赖，需要自行安装。

* C 语言编译器
* make 实用程序
* pcre 开发包
* zlib 开发包
* git
* bash
* tmux

文末附录有各系统安装依赖的命令。

安装完依赖之后，统一用下面的命令就可以安装：

```
curl -sL https://github.com/mudclient/paotin/-/raw/install/unix-install | bash
```

## 附各系统的依赖安装命令

### macOS

```
brew update && brew install gcc make gnutls pcre zlib git bash tmux curl neovim
```

### Ubuntu

```
sudo apt update && sudo apt-get install -y build-essential zlib1g-dev libpcre3-dev git bash tmux curl
```

### Debian

```
sudo apt update && sudo apt-get install -y build-essential zlib1g-dev libpcre3-dev git bash tmux curl
```

### Fedora

```
sudo yum install -y which make gcc zlib-devel pcre-devel git bash tmux curl
```

### CentOS

```
sudo yum install -y which make gcc zlib-devel pcre-devel git bash tmux curl
```

已知问题： CentOS 7 及以前的版本中，tmux 的版本太低，建议手动升级至 3.X 版本。

### FreeBSD

```
sudo pkg update && sudo pkg install -y gcc make++ pcre zlib-ng git bash tmux curl neovim
```

### OpenBSD

```
sudo pkg_add -u && sudo pkg_add pcre git bash curl neovim
```
