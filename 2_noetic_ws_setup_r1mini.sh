#!/bin/bash

echo "@@@@@ install additional packages @@@@@"
sudo apt install -y \
	terminator \


echo "@@@@@ make workspace and catkin_make @@@@@"
mkdir -p ~/ros_ws/src
cd ~/ros_ws
catkin_make
mkdir -p ~/carto_ws


echo "@@@@@ modify bashrc - shotcut, export @@@@@"
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
echo "alias sai='sudo apt install'" >> ~/.bashrc
echo "alias cw='cd ~/ros_ws'" >> ~/.bashrc
echo "alias cs='cd ~/ros_ws/src'" >> ~/.bashrc
echo "alias cm='cd ~/ros_ws && catkin_make'" >> ~/.bashrc
echo "alias eb='nano ~/.bashrc'" >> ~/.bashrc
echo "alias sb='source ~/.bashrc'" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://localhost:11311" >> ~/.bashrc
echo "export ROS_HOSTNAME=localhost" >> ~/.bashrc


echo "@@@@@ ros packages clone and catkin_make @@@@@"
cd ~/carto_ws
wstool init src
wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src
rosdep update
source /opt/ros/noetic/setup.bash
sed -i -e "s%<depend>libabsl-dev</depend>%<\!--<depend>libabsl-dev</depend>-->%g" src/cartographer/package.xml
rosdep install --from-paths src --ignore-src -r -y
src/cartographer/scripts/install_abseil.sh
catkin_make_isolated --install --use-ninja -j$(($(nproc) - 1)) -l$(($(nproc) - 1))
cd ~/ros_ws/src
git clone https://github.com/omorobot/omo_r1mini.git -b dev_noetic
git clone https://github.com/omorobot/ydlidar_ros.git
cd ~/ros_ws
catkin_make


echo -e "\033[31m"workspace setup is done"\033[0m"
echo -e "\033[31m"system is rebooting in 5sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 4sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 3sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 2sec"\033[0m"
sleep 1
echo -e "\033[31m"system is rebooting in 1sec"\033[0m"
sleep 1
sudo reboot now
exit 0
