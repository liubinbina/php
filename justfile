build:
    docker build . -t phpfb:7.2 --progress=plain

test:
    docker run --rm \
        --name=test \
        -p 8088:80 \
        -v $(pwd)/../mantis-php/mantis:/var/www/html \
        phpfb:7.2