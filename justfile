build:
    docker build . -t phpf:7.2 --progress=plain

info:
    docker run --rm \
        --name=test \
        -p 8088:80 \
        -p 9001:9000 \
        -e XDEBUG_CONFIG='remote_host=172.178.5.21 remote_port=9001 remote_enable=1 idekey=XDEBUG_ECLIPSE' \
        -v vscode-server-php:/root/.vscode-server \
        -v $(pwd)/index.php:/srv/index.php \
        phpf:7.2

test:
    docker run --rm \
        --name=test \
        -p 8088:80 \
        -v vscode-server-php:/root/.vscode-server \
        -v $(pwd)/../mantis-php/mantis:/srv \
        phpf:7.2

debug:
    docker run --rm -it \
        --network=container:test \
        --pid=container:test \
        deb

start:
    curl -b "XDEBUG_SESSION=sublime.xdebug" http://localhost:8088/