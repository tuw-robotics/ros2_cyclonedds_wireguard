# ros2_cyclonedds_wireguard
ROS2 Sample Project with wireguard and cyclonedds

## Setup
wireguard networks with interface name wg-n16 

Peers with IP:
- 192.168.33.80
- 192.168.33.51


## Example

on 192.168.33.80 run:
```
ros2 run examples_rclcpp_minimal_subscriber subscriber_lambda
```


on 192.168.33.51 run:
```
ros2 run examples_rclcpp_minimal_publisher publisher_lambda
```
