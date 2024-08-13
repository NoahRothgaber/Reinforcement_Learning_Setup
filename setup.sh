#!/bin/bash
apt -y upgrade
apt -y install python3.10
snap install code --classic
apt -y install python3-pip
pip install torch
apt -y install swig
apt -y install git
pip install matplotlib
pip install gymnasium
pip install gymnasium[box2d]
pip install gymnasium[classic-control]
git clone -b categorical https://github.com/NoahRothgaber/reinforcement_learning
cd reinforcement_learning/rainbow_dqn
python3 agent.py cartpole1 --train