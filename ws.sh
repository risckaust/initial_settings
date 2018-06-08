# catkin workspace and build PX4
source ~/.bashrc
cd ~
mkdir -p ./catkin_ws/src
cd ./catkin_ws
catkin init
# Build your workspace
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
source ~/.bashrc
