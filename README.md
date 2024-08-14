This script was created to setup a linux machine with the programs, dependencies, and environments for use in the training of reinforcement learning algorithms. It will install

Python 3.10  
Gymnasium and the Box2D and Classic Control Environments  
Visual Studio Code  
Numpy and MatPlotLib  
Ros2 Humble  
Pytorch
Swig (gym dependency)  
Terminator (Terminal Multiplexer)
Pygame

To use the script, clone this repository using the following command  
git clone https://github.com/NoahRothgaber/Reinforcement_Learning_Setup  

Move into the clone repository with the next command
cd reinforcement_learning_setup  

Change the execute permissions of the script with the next command
chmod +777 setup.sh  

To run the script that installs both gymnasium and ros2, just type the following  
sudo ./setup.sh

The script also provides two optional positional arguments.  

To install just gymnasium, the command is  
sudo ./setup.sh --just-gym  

To install just ros2 humble, the command is  
sudo ./setup.sh --just-ros2  