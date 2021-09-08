FROM ubuntu:20.04 as cacher

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    qtbase5-dev \
    libqt5svg5-dev \
    libzmq3-dev \
    libdw-dev \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --recurse-submodules https://github.com/BehaviorTree/Groot.git /opt/Groot

FROM cacher as builder

WORKDIR /opt/Groot

RUN mkdir build \
    && cd build \
    && cmake .. \
    && make

FROM builder as runner

RUN mkdir -m 700 /tmp/runtime
ENV XDG_RUNTIME_DIR=/tmp/runtime

CMD /opt/Groot/build/Groot
