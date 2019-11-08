build version="5.6":
    docker build . -t nnurphy/phpf:{{version}} \
        --build-arg PHP_VERSION={{version}} \
        --build-arg s6url=http://172.178.1.204:2015/s6-overlay-amd64.tar.gz \
        --build-arg wstunnel_url=http://172.178.1.204:2015/tools/wstunnel_linux_x64


build-gcc:
    docker build . -t nnurphy/phpf:7.2 -f Dockerfile-gcc \
        --build-arg s6url=http://172.178.1.204:2015/s6-overlay-amd64.tar.gz \
        --build-arg php_url=http://172.178.1.204:2015/php-7.2.24.tar.xz \
        --build-arg wstunnel_url=http://172.178.1.204:2015/tools/wstunnel_linux_x64


test:
    docker run --rm \
        --name=test \
        -p 8090:80 \
        -v vscode-server-php:/root/.vscode-server \
        -v $(pwd)/id_ecdsa.php.pub:/root/.ssh/authorized_keys \
        nnurphy/phpf:7.2

# wstunnel -L 2223:127.0.0.1:80 ws://127.0.0.1:80 --upgradePathPrefix=wstunnel-S6cHCQuPtVubM

k8sc token:
    docker run --rm \
        --name=wsc \
        -p 2233:8080 \
        wstunnel -L 0.0.0.0:8080:127.0.0.1:22 ws://172.178.5.21:8090 --upgradePathPrefix=wstunnel-{{token}}

debug:
    docker run --rm -it \
        --network=container:test \
        --pid=container:test \
        deb

export:
    #!/bin/zsh
    docker save nnurphy/phpf:7.2 nnurphy/phpf:5.6 \
        | zstd -c -18 -T0 \
        | tee >(ssh eng-37  'zstd -d | docker load') \
        | tee >(ssh eng     'zstd -d | docker load') \
        | tee >(ssh eng-dev 'zstd -d | docker load') \
        | tee >(ssh xmh     'zstd -d | docker load') \
        > ~/pub/Platform/php/phpf.tar.zst