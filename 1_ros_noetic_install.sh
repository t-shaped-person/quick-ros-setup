#!/bin/bash

echo -e "@@@@@ Setup your sources.list @@@@@"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'


echo "@@@@@ Set up your keys @@@@@"
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -


echo "@@@@@ Installation @@@@@"
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
	ros-noetic-desktop-full \
	python3-rosdep \
	python3-rosinstall \
	python3-rosinstall-generator \
	python3-wstool \
	build-essential \
	nano git net-tools openssh-server \
	python3-pip \
	python3-bloom \
	python3-rosclean \
	liburdfdom-tools \
	python3-catkin-lint \
	python3-catkin-tools \
	ros-noetic-usb-cam \
	ros-noetic-gmapping \
	ros-noetic-laser-proc \
	ros-noetic-map-server \
	ros-noetic-navigation \
	ros-noetic-rgbd-launch \
	ros-noetic-rosserial-python \
	ros-noetic-rosserial-server \
	ros-noetic-teleop-twist-joy \
	ros-noetic-rosserial-arduino \
	ros-noetic-teleop-twist-keyboard \
	ros-noetic-depthimage-to-laserscan \
	ninja-build stow libceres-dev liblua5.2-dev \


echo "@@@@@ Environment setup @@@@@"
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc


echo "@@@@@ Dependencies for building packages @@@@@"
if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then
	sudo rosdep init
	echo "@@@@@ rosdep init is done @@@@@"
fi
rosdep update


echo -e "\033[31m"ros noetic installation is done"\033[0m"
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
