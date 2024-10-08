#!/bin/bash
# Created by Noah Rothgaber 8/13/2024
# Setup Gymnasium, VsCode, Git, and Terminator, ros2 coming soon...
# Ros 2 Humble Setup
username=$(logname)

# Function definitions
install_gym() {
    apt -y upgrade
    apt -y update # normally shouldn't be required but one pc had issues and liked update over upgrade
    apt -y install python3.10
    apt -y install python3-pip
    sudo -u $username pip install torch
    apt -y install swig git terminator
    # Great terminal windowing tool, allows for splitting of terminal windows easily        
    sudo -u $username pip install matplotlib gymnasium gymnasium[box2d] gymnasium[classic-control]
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
    # next line looks strange but, it's just automating the "ENTER" press required for the command to run
    yes | add-apt-repository universe
    apt update && apt -y install curl
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
    apt -y update
    apt -y upgrade
    apt -y install ros-humble-desktop ros-dev-tools
    source /opt/ros/humble/setup.bash
}

test_ros2(){
    sudo -u $username terminator -e "bash -c 'source /opt/ros/humble/setup.bash && ros2 run demo_nodes_cpp talker; exec bash'" &
    sudo -u $username terminator -e "bash -c 'source /opt/ros/humble/setup.bash && ros2 run demo_nodes_cpp listener; exec bash'" &
}

test_gym(){
    cd /home/$username
    sudo -u $username git clone -b categorical https://github.com/NoahRothgaber/reinforcement_learning
    cd /home/$username/reinforcement_learning/rainbow_dqn_pytorch/
    sudo -u $username terminator -e "bash -c 'python3 agent.py cartpole1 --train; exec bash'" &
}
# Main script logic
if [ -z "$1" ]; then
    echo "Installing gymnasium and ros2 humble."
    sleep 2
    snap install code --classic
    install_gym
    install_ros2
    # If you wish, comment out these next 2 lines if you don't want to test
    test_gym
    test_ros2
elif [ "$1" = "--just-gym" ]; then
    echo "Only installing gymnasium!"
    sleep 2
    snap install code --classic
    install_gym
    # If you wish, comment out this next line if you don't want to test
    test_gym
elif [ "$1" = "--just-ros2" ]; then
    echo "Only installing ros2 humble!"
    sleep 2
    snap install code --classic
    install_ros2
    # If you wish, comment out this next line if you don't want to test
    test_ros2
else
    echo "The optional arguments are --just-gym and --just-ros2, you can install both by just running the script with no positional arguments. <sudo ./setup.sh>"
fi
