#!/bin/sh
cd ~
sudo apt-get update
sudo apt-get install vim terminator curl gparted -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

# ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full -y
sudo rosdep init
rosdep update
rossource="source /opt/ros/kinetic/setup.bash"
if grep -Fxq "$rossource" ~/.bashrc; then echo ROS setup.bash is already in .bashrc; else echo "$rossource" >> ~/.bashrc; fi 
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools -y

# PX4 Firmware
curl https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim_common_deps.sh -o common_deps.sh
chmod +x common_deps.sh
. ./common_deps.sh

sudo apt-get install protobuf-compiler libeigen3-dev libopencv-dev -y

cd ~/src/Firmware
git checkout v1.7.3

# MavROS
sudo apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras -y

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh

sudo pip install pymap3d
sudo pip install lap
