#!/bin/bash
username=$(logname)
apt -y upgrade
apt -y install python3.10
snap install code --classic

apt -y install python3-pip
sudo -u $username pip install torch
apt -y install swig
apt -y install git        
sudo -u $username pip install matplotlib
sudo -u $username pip install gymnasium
sudo -u $username pip install gymnasium[box2d]
sudo -u $username pip install gymnasium[classic-control]
sudo -u $username git clone -b categorical https://github.com/NoahRothgaber/reinforcement_learning
cd /home/$username/reinforcement_learning/rainbow_dqn_pytorch
sudo -u $username python3 agent.py cartpole1 --train