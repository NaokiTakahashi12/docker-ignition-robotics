
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt upgrade -y \
    && . /etc/os-release \
    && apt install -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        software-properties-common \
        wget \
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && add-apt-repository -y ppa:ubuntu-x-swat/updates \
    && apt update \
    && apt dist-upgrade -y \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        ignition-blueprint \
    && apt --purge remove -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        software-properties-common \
        wget \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

