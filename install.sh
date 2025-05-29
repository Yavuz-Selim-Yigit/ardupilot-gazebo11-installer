#!/bin/bash

echo "=== [1/8] Sistemi güncelliyor..."
sudo apt update && sudo apt upgrade -y

echo "=== [2/8] Gerekli bağımlılıkları kuruyor..."
sudo apt install -y git wget curl gnupg lsb-release python3-pip build-essential ccache cmake g++ protobuf-compiler libprotobuf-dev libprotoc-dev libeigen3-dev libxml2-utils

echo "=== [3/8] Gazebo 11 deposunu ekliyor..."
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt update

echo "=== [4/8] Gazebo 11 kuruyor..."
sudo apt install -y gazebo11 libgazebo11-dev

echo "=== [5/8] ArduPilot kaynak kodu indiriliyor..."
cd ~
git clone https://github.com/ArduPilot/ardupilot.git
cd ardupilot
git submodule update --init --recursive

echo "=== [6/8] ArduPilot bağımlılıkları kuruluyor..."
Tools/environment_install/install-prereqs-ubuntu.sh -y
. ~/.profile

echo "=== [7/8] ArduPilot derleniyor (SITL - Rover/Sub destekli)..."
./waf configure --board sitl
./waf rover
./waf sub

echo "=== [8/8] ArduPilot-Gazebo eklentisi kuruluyor..."
cd ~
git clone https://github.com/ArduPilot/ardupilot_gazebo.git
cd ardupilot_gazebo
mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install

echo "=== Ortam değişkenleri ayarlanıyor..."
echo 'export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:/usr/local/lib' >> ~/.bashrc
echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ardupilot_gazebo/models' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' >> ~/.bashrc
source ~/.bashrc

echo "Kurulum tamamlandı!"

echo ""
echo "Test için komutlar:"
echo "Terminal 1:"
echo "  cd ~/ardupilot"
echo "  ./Tools/autotest/sim_vehicle.py -v APMrover2 -f gazebo-rover --console --map"
echo ""
echo "Terminal 2:"
echo "  gazebo --verbose ~/ardupilot_gazebo/worlds/rover.world"
