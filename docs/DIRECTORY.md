## 目录结构和文件说明

```
> tree -L 2
.
├── HOW-TO-PLAY.md      -- 简要说明文件
├── bin
│   ├── start-ui        -- 启动游戏环境（第一步，如果是 Docker 环境则已执行过了）
│   ├── start           -- 启动游戏账号（第二步）
│   ├── doc             -- markdown 文档查看工具。如果显示异常，请用 cat 代替。
│   └── tt++            -- tintin++ 主程序
├── docs
│   └── DIRECTORY.md    -- 本文件
├── etc                 -- 客户端配置文件目录（跨 ID 共享）
├── data                -- 客户端数据文件目录（跨 ID 共享）
├── framework           -- 主框架程序，不建议修改
├── ids                 -- 启动配置文件存放目录。建议以 ID 命名，不同 ID 不同文件
│   ├── DEFAULT         -- 所有 ID 的默认配置，可以在启动配置文件里定制
│   └── EXAMPLE         -- 一个启动配置文件的例子
├── log                 -- 日志存放目录
├── plugins             -- 插件存放目录
│   ├── lib             -- 基础插件
│   ├── basic           -- 基本插件
│   └── shortcut.tin    -- 其它插件
└── var                 -- Docker 环境下用作本地存储用的挂载目录
    ├── ids             -- 本地启动配置文件
    ├── etc             -- 本地配置
    ├── log             -- 本地日志
    └── plugins         -- 本地插件目录
```
