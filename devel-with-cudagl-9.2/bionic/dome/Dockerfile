
FROM naokitakahashi12/ignition:buildenv-cudagl-9.2-bionic

ENV CXX=g++-8

RUN apt update \
    && apt install -y --no-install-recommends \
        g++-8 \
        wget \
        git \
        cmake \
        python3-vcstool \
        python3-colcon-common-extensions \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8 \
    && mkdir -p /ign_ws/src \
    && cd /ign_ws \
    && wget https://raw.githubusercontent.com/ignition-tooling/gazebodistro/master/collection-dome.yaml \
    && vcs import src < collection-dome.yaml \
    && colcon build \
        --merge-install \
        --symlink-install \
        --executor parallel \
        --parallel-workers 4 \
        --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        --cmake-args -DBUILD_TESTING=OFF \
    && apt --purge remove -y \
        g++-8 \
        wget \
        git \
        cmake \
        python3-vcstool \
        python3-colcon-common-extensions \
    && rm -rf collection-dome.yaml \
    && rm -rf build \
    && rm -rf log \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint/devel.sh /ign_entrypoint.sh
ENTRYPOINT ["/ign_entrypoint.sh"]

CMD ["/bin/bash"]

