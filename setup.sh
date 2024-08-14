#!/bin/bash
# Created by Noah Rothgaber 8/13/2024
# Setup Gymnasium, VsCode, Git, and Terminator, ros2 coming soon...
username=$(logname)
# some lines are ran with sudo -u $username -
# This is because pip does not like being ran with sudo permissions -
# But apt requires it
apt -y upgrade
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
sudo -u $username python3 agent.py cartpole1 --train