# Create and initialize catkin workspace
source ~/.bashrc
cd ~
mkdir -p ./catkin_ws/src
cd ./catkin_ws
catkin init
# Build your workspace
catkin build
# Always source your workspace after each build, so changes will take effect.
source devel/setup.bash
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
# Navigate to src folder of the workspace
cd ~/catkin_ws/src
# Create symlink to the px4 package
ln -s ~/src/Firmware/ px4
# Create symlink to the simulation package
ln -s ~/src/Firmware/Tools/sitl_gazebo/ mavlink_sitl_gazebo
# Build workspace
catkin build
source ~/.bashrc
