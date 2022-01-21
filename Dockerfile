FROM varunagrawal/ros-indigo-fetch-vnc:latest

# Baxter workstation setup - https://sdk.rethinkrobotics.com/wiki/Workstation_Setup

# Surce ROS and build
# RUN source /opt/ros/indigo/setup.bash
# WORKDIR /home/ubuntu/ros_ws
# RUN catkin_make && catkin_make install

# Install Baxter SDK dependencies
RUN apt-get update && apt-get install wget

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

RUN apt-get update \
    && apt-get install -y git-core python-argparse python-wstool python-vcstools python-rosdep ros-indigo-control-msgs ros-indigo-joystick-drivers

# Install Baxter SDK
WORKDIR /root/ros_ws/src
RUN wstool init . \
    && wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter/master/baxter_sdk.rosinstall \
    && wstool update
# RUN source /opt/ros/indigo/setup.bash
# WORKDIR /home/ubuntu/ros_ws
# RUN catkin_make && catkin_make install

# Install Baxter Simulator
RUN apt-get install -y ros-indigo-baxter-simulator

# Install Baxter Simulator dependencies
RUN apt-get update \
    && apt-get install -y gazebo2 ros-indigo-qt-build ros-indigo-driver-common ros-indigo-gazebo-ros-control ros-indigo-gazebo-ros-pkgs ros-indigo-ros-control ros-indigo-control-toolbox ros-indigo-realtime-tools ros-indigo-ros-controllers ros-indigo-xacro python-wstool ros-indigo-tf-conversions ros-indigo-kdl-parser

# Download baxter.sh script
WORKDIR /root/ros_ws
RUN wget https://github.com/RethinkRobotics/baxter/raw/master/baxter.sh
RUN chmod u+x baxter.sh

ENTRYPOINT ["/startup.sh"]