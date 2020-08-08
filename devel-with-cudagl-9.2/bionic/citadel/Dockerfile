
FROM naokitakahashi12/ignition:buildenv-cudagl-9.2-bionic

ENV CXX=g++-8

RUN apt update \
    && apt install -y \
        g++-8 \
        wget \
        git \
        python3-pip \
    && python3 -m pip --no-cache-dir install \
        vcstool \
        colcon-common-extensions \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8 \
    && mkdir -p /ign_ws/src \
    && cd /ign_ws \
    && wget https://raw.githubusercontent.com/ignition-tooling/gazebodistro/master/collection-citadel.yaml \
    && vcs import src < collection-citadel.yaml \
    && colcon build \
        --merge-install \
        --symlink-install \
        --executor parallel \
        --parallel-workers 4 \
    && python3 -m pip uninstall -y \
        vcstool \
        colcon-common-extensions \
    && apt remove -y \
        g++-8 \
        wget \
        git \
        python3-pip \
    && rm -rf collection-citadel.yaml \
    && rm -rf build \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
