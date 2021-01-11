
FROM naokitakahashi12/ignition:buildenv-cudagl-11.0-focal

RUN apt update \
    && apt install -y --no-install-recommends \
        g++ \
        gcc \
        wget \
        git \
        cmake \
        make \
        lsb-release \
        python3-vcstool \
        python3-colcon-common-extensions \
    && mkdir -p /ign_ws/src \
    && cd /ign_ws \
    && wget https://raw.githubusercontent.com/ignition-tooling/gazebodistro/master/collection-citadel.yaml \
    && vcs import src < collection-citadel.yaml \
    && colcon build \
        --merge-install \
        --symlink-install \
        --executor parallel \
        --parallel-workers 4 \
        --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        --cmake-args -DBUILD_TESTING=OFF \
    && apt --purge remove -y \
        g++ \
        gcc \
        wget \
        git \
        cmake \
        make \
        lsb-release \
        python3-vcstool \
        python3-colcon-common-extensions \
    && rm -rf collection-citadel.yaml \
    && rm -rf build \
    && rm -rf log \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint/devel.sh /ign_entrypoint.sh
ENTRYPOINT ["/ign_entrypoint.sh"]

CMD ["/bin/bash"]

