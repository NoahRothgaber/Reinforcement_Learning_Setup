#!/bin/bash
# Created by Noah Rothgaber 8/13/2024
# Setup Gymnasium, VsCode, Git, and Terminator, ros2 coming soon...
# Ros 2 Humble Setup
username=$(logname)
# some lines are ran with sudo -u $username -
# This is because pip does not like being ran with sudo permissions -
# But apt requires it
# optional flags are --just-gym and --just-ros2 to specify installations.
if[ -z $1 ]
 then
    install_gym()
    install_ros2()
elif [ $1 = "--just-gym" ]
 then
     install_gym()
elif [$1 = "--just-ros2" ]
 then
    install_ros2()
    sudo -u $username terminator -e "bash -c 'source /opt/ros/humble/setup.bash && ros2 run demo_nodes_cpp talker; exec bash'" &
    sudo -u $username terminator -e "bash -c 'source /opt/ros/humble/setup.bash && ros2 run demo_nodes_cpp listener; exec bash'" &
else
    echo "The optional arguments are --just-gym and --just-ros2, you can install both by just running the script"
fi

install_gym() {
    pt -y upgrade
apt -y update #normally shouldn't be required but one pc had issues and liked update over upgrade
apt -y install python3.10
snap install code --classic
apt -y install python3-pip
sudo -u $username pip install torch
apt -y install swig
apt -y install git
apt -y install terminator
# Great terminal windowing tool, allows for splitting of terminal windows easily        
sudo -u $username pip install matplotlib
sudo -u $username pip install gymnasium
sudo -u $username pip install gymnasium[box2d]
sudo -u $username pip install gymnasium[classic-control]
cd /home/$username
# If you wish, comment out these next three lines if you don't want to test
# These lines grab one of my repos for the rainbow DQN and train it
# This shows that the environments work etc... but isn't necessary
sudo -u $username git clone -b categorical https://github.com/NoahRothgaber/reinforcement_learning
cd /home/$username/reinforcement_learning/rainbow_dqn_pytorch/
sudo -u $username terminator -e "bash -c 'python3 agent.py cartpole1 --train; exec bash'" &
}

install_ros2(){
# runs agent training in a separate terminator window so we can show ros2 and gym are both working. 
# ros 2 section begins
# commands taken from https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
apt -y install locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
apt -y install software-properties-common
# next line looks strange but, it's just automating the "ENTER" press requried for the command to run
yes | add-apt-repository universe
apt update && apt -y install curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
apt -y update
apt -y upgrade
apt -y install ros-humble-desktop
apt -y install ros-dev-tools
source /opt/ros/humble/setup.bash
}
