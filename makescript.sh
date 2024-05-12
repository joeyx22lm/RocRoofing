function _buildDockerCtxTag {
    PROJECT_DIR="$1"
    BASE_IMAGE="$2"
    cat "$PROJECT_DIR/Dockerfile" \
        | grep "ENV VERSION" \
        | sed "s/ENV VERSION=/$BASE_IMAGE\:/" \
        | sed 's/\"//g'
}

function clean {
    PROJECT_DIR="$1"
    DOCKER_BUILD_CTX_IMAGE="$2"
    if [ ! -z "$(docker images -q $(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE))" ]; then
        docker image rm -f "$(docker images -q $(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE))"
    fi
}

function shell {
    PROJECT_DIR="$1"
    DOCKER_BUILD_CTX_IMAGE="$2"

    if [[ -z "$(docker images -q $(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE))" ]];
    then
        docker build -t "$(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE)" "$PROJECT_DIR"
    fi

    docker run --rm -it \
        -v "$PROJECT_DIR:/src" \
        -p "0.0.0.0:3000:3000" \
        "$(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE)"
}

function run_command {
    PROJECT_DIR="$1"
    DOCKER_BUILD_CTX_IMAGE="$2"

    if [[ -z "$(docker images -q $(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE))" ]];
    then
        docker build -t "$(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE)" "$PROJECT_DIR"
    fi

    docker run --rm -it \
        -v "$PROJECT_DIR:/src" \
        -p "0.0.0.0:3000:3000" \
        "$(_buildDockerCtxTag $PROJECT_DIR $DOCKER_BUILD_CTX_IMAGE)" -c "$3"
}
