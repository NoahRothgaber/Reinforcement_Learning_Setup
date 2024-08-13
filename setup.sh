#!/bin/bash
apt -y upgrade
apt -y install python3.10
snap install code --classic
apt -y install python3-pip
pip install torch
apt -y install swig
pip install box2d
apt -y install git
pip install matplotlib