# STAGE 1，在临时镜像中编译 tintin
FROM alpine:latest

# 安装编译器和依赖包
RUN    apk update \
    && apk add --no-cache git gcc libc-dev zlib-dev zlib-static pcre-dev make curl

RUN git clone --depth 1 https://github.com/junegunn/vim-plug.git /vim-plug
RUN git clone --depth 1 https://github.com/dzpao/vim-mbs.git /vim-mbs
RUN git clone --depth 1 https://github.com/morhetz/gruvbox.git /gruvbox
RUN git clone --depth 1 https://github.com/yegappan/mru.git /mru
RUN git clone --depth 1 https://github.com/jlanzarotta/BufExplorer.git /BufExplorer
RUN git clone --depth 1 https://github.com/mhinz/vim-startify.git /vim-startify

RUN git clone --depth 1 https://github.com/mudclient/tintin.git --branch beta-develop
WORKDIR /tintin/src/

# 这里 hack 了一下 gcc，强制静态编译。
ENV PATH=.:/sbin:/bin:/usr/sbin:/usr/bin
RUN echo '/usr/bin/gcc --static $*' > gcc && chmod +x gcc
RUN ./configure && make && strip tt++

# STAGE 2: 生成最终镜像
FROM alpine:latest
LABEL name="paotin"
LABEL maintainer="dzp <danzipao@gmail.com>"

ENV LANG=zh_CN.UTF8     \
    TERM=xterm-256color \
    SHELL=/bin/bash     \
    HOME=/paotin        \
    PATH=/paotin/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /paotin/

RUN    apk update \
    && apk add --no-cache tmux bash ncurses less neovim nano

# 设置时区为上海
RUN apk add --no-cache tzdata \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
        && echo "Asia/Shanghai" > /etc/timezone                 \
        && apk del tzdata

COPY profile.sh         /paotin/.bash_profile
COPY tmux.conf          /paotin/.tmux.conf

COPY HOW-TO-PLAY.md     /paotin/
COPY bin                /paotin/bin/
COPY docs               /paotin/docs/
COPY etc                /paotin/etc/
COPY framework          /paotin/framework/
COPY plugins            /paotin/plugins/
COPY mud                /paotin/mud/

COPY ids/EXAMPLE        /paotin/ids/
COPY ids/DEFAULT        /paotin/ids/

COPY init.vim           /paotin/.config/nvim/

COPY --from=0 /vim-plug/plug.vim    /paotin/.local/share/nvim/site/autoload/plug.vim
COPY --from=0 /gruvbox      /paotin/.local/share/nvim/plugged/gruvbox/
COPY --from=0 /vim-mbs      /paotin/.local/share/nvim/plugged/vim-mbs/
COPY --from=0 /mru          /paotin/.local/share/nvim/plugged/mru/
COPY --from=0 /BufExplorer  /paotin/.local/share/nvim/plugged/BufExplorer/
COPY --from=0 /vim-startify /paotin/.local/share/nvim/plugged/BufExplorer/

COPY --from=0 /tintin/src/tt++ /paotin/bin/

RUN mkdir -p /paotin/log/
RUN mkdir -p /paotin/tmux/

ENTRYPOINT ["/bin/bash", "-i", "/paotin/bin/start-ui"]
