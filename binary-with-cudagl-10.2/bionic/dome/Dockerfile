
FROM nvidia/cudagl:10.2-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt upgrade -y \
    && . /etc/os-release \
    && apt install -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        wget \
        software-properties-common \
    && echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list \
    && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        ignition-dome \
    && apt --purge remove -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        wget \
        software-properties-common \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

