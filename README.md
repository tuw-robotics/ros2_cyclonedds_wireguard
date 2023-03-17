# ros2_cyclonedds_wireguard
ROS2 Sample Project with wireguard and cyclonedds with a publisher subscriber example.

In order to use ROS2 with Cyclone DDS over a  wireguard network you have to export the enviroment variables **RMW_IMPLEMENTATION** and **CYCLONEDDS_URI**. 

```
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///$(pwd)/cyclonedds.xml 
```

## Setup
wireguard networks with interface name wg-n16 

Peers with IP:
- 192.168.33.80
- 192.168.33.51


## Example
Compile the project with

```
ros-$ROS_DISTRO-rmw-cyclonedds-cpp
source env.sh
colcon build
```

on 192.168.33.80 run:
```
ros2 run examples_rclcpp_minimal_subscriber subscriber_lambda
```


on 192.168.33.51 run:
```
ros2 run examples_rclcpp_minimal_publisher publisher_lambda
```
