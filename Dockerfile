FROM osrf/ros:indigo-desktop-full

ENV DEBIAN_FRONTEND noninteractive

# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && add-apt-repository ppa:fcwu-tw/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor \
        openssh-server pwgen sudo vim-tiny emacs24 \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        nginx \
        python-pip python-dev build-essential \
        mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta \
        dbus-x11 x11-utils \
        terminator \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Install aptitude to install fetch-gazebo-demo
RUN apt-get update && \
    apt-get install -y aptitude
RUN printf 'n\nY\nY\n' | aptitude install ros-indigo-fetch-gazebo-demo

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc

# tini for subreap
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

RUN cp /usr/share/applications/terminator.desktop /root/Desktop

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]