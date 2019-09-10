端口必须绑定,并且一致(不要问为什么))
``` bash
-p 9001:9001
```

如果不是默认值,使用环境变量设置
``` bash
-e XDEBUG_CONFIG='remote_port=9002'
```

``` bash
docker run --rm \
    --name=test \
    -p 8088:80 \
    -p 9002:9002 \
    -e XDEBUG_CONFIG='remote_port=9002' \
    -v vscode-server-php:/root/.vscode-server \
    -v $(pwd)/index.php:/srv/index.php \
    phpf:7.2
```

使用 vscode 远程模式进入容器, 打开 `/srv` 目录

添加调试配置
``` json
{
    "name": "Listen for XDebug",
    "type": "php",
    "request": "launch",
    "port": 9002
}
```
注意端口应与之前设置保持一致
