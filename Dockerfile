# STAGE 1，在临时镜像中编译 tintin
FROM alpine:latest

# 安装编译器和依赖包
RUN    apk update \
    && apk add --no-cache git gcc libc-dev zlib-dev zlib-static pcre-dev make

RUN git clone https://github.com/mudclient/tintin.git --branch beta-develop
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
    && apk add --no-cache tmux bash

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

COPY ids/EXAMPLE        /paotin/ids/
COPY ids/DEFAULT        /paotin/ids/

COPY --from=0 /tintin/src/tt++ /paotin/bin/

RUN mkdir -p /paotin/log/
RUN echo debug log > /paotin/log/debug.log
RUN echo quest log > /paotin/log/quest.log
RUN echo tt log > /paotin/log/tt.log

ENTRYPOINT ["/bin/bash", "/paotin/bin/start-ui"]
