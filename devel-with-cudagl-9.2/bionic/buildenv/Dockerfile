
FROM nvidia/cudagl:9.2-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        lsb-release \
        software-properties-common \
        wget \
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && apt update \
    && apt remove -y \
        lsb-release \
        software-properties-common \
        wget \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /ver/lib/apt/lists/*

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        python3-pip \
    ## from official documentation
    && apt install -y \
        cmake freeglut3-dev libavcodec-dev libavdevice-dev \
        libavformat-dev libavutil-dev libdart6-collision-ode-dev libdart6-dev \
        libdart6-utils-urdf-dev libfreeimage-dev libgflags-dev \
        libglew-dev libgts-dev libogre-1.9-dev libogre-2.1-dev \
        libprotobuf-dev libprotobuf-dev libprotoc-dev libqt5core5a \
        libswscale-dev libtinyxml2-dev libtinyxml-dev pkg-config \
        protobuf-compiler python qml-module-qt-labs-folderlistmodel \
        qml-module-qt-labs-settings qml-module-qtquick2 \
        qml-module-qtquick-controls qml-module-qtquick-controls2 \
        qml-module-qtquick-dialogs qml-module-qtquick-layouts \
        qml-module-qtqml-models2 qtbase5-dev qtdeclarative5-dev \
        qtquickcontrols2-5-dev ruby ruby-ronn uuid-dev libzip-dev \
        libjsoncpp-dev libcurl4-openssl-dev libyaml-dev libzmq3-dev \
        libsqlite3-dev libwebsockets-dev swig ruby-dev \
    ## Shortage packages
    && python3 -m pip --no-cache-dir install --upgrade \
        setuptools \
    && python3 -m pip --no-cache-dir install \
        six \
    && apt install -y \
        libbenchmark-dev \
        python-psutil \
    && apt remove -y \
        python3-pip \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

