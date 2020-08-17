
FROM nvidia/cudagl:10.2-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt upgrade -y \
    && . /etc/os-release \
    && apt install -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        software-properties-common \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743 \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list \
    && apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        ignition-citadel \
    && apt --purge remove -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        software-properties-common \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

