#!/bin/bash
apt -y upgrade
apt -y install python3.10
snap install code --classic
apt -y install python3-pip
pip install torch
apt -y install swig
apt -y install git
pip install matplotlibpip
pip install gymnasium
pip install gymnasium[box2d]
pip install gymnasium[classic-control]