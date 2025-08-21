# ros1-noetic-docker
にょっす

# nvidia を積んでいない場合にrealsenseを使いたいっぴ

echo 256 | sudo tee /sys/module/usbcore/parameters/usbfs_memory_mb

# docker 

cd ros1_noetic/docker/
docker compose build

# docker 起動
xhost +local:

cd ros1_noetic/docker/

sudo docker compose up -d ros-noetic

sudo docker exec -it ros-noetic bash

sudo docker exec -it -u 0 ros-noetic bash

sudo docker compose stop


# リスト
docker system df

sudo docker images

# 削除
sudo docker rmi　

# コンテナ削除
sudo docker rm コンテナ名またはID

# ros-humble-ros1-bridge
<!-- export ROS_MASTER_URI=http://dasnote20-RL7C-R45-4:11311/ -->

source /opt/ros/humble/setup.bash 
source ~/ros-humble-ros1-bridge-builder/ros-humble-ros1-bridge/install/local_setup.bash 
ros2 run ros1_bridge dynamic_bridge


# realsense 



