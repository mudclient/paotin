# 默认行为，也就是本命令
help:
    @echo '输入 just <recipe> 执行预定义的动作。'
    @just --list --unsorted

# 制作镜像
build-image:
    docker image rm mudclient/paotin
    docker image prune
    docker build -t mudclient/paotin .

# 制作镜像（beta 版）
build-image-beta:
    docker image rm mudclient/paotin:beta
    docker image prune
    docker build -t mudclient/paotin:beta .
