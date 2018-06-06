#!/bin/sh
cd ~
sudo apt-get update
sudo apt-get install vim terminator curl -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

# ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools -y
. ~/.bashrc

# PX4 Firmware
curl https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim_common_deps.sh -o
chmod +x common_deps.sh
. ./common_deps.sh

sudo apt-get install protobuf-compiler libeigen3-dev libopencv-dev -y

cd ~/src/Firmware
git checkout v1.7.3

# catkin workspace and build PX4
cd ~
mkdir -p ./catkin_ws/src
cd ./catkin_ws/src
catkin_init_workspace
wstool init
# Build your workspace
cd ~/catkin_ws
catkin build
# Always source your workspace after each build, so changes take effect.
source devel/setup.bash
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc


cd ~/catkin_ws/src
# create symlink to the px4 package
ln -s ~/src/Firmware/ px4
# Create symlink to the simulation package
ln -s ~/src/Firmware/Tools/sitl_gazebo/ mavlink_sitl_gazebo
catkin build
. ~/.bashrc

# MavROS
sudo apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh

sudo pip install pymap3d
sudo pip install lap
