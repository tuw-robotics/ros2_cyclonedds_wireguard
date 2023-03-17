ARG OWNER=osrf
ARG ROS_DISTRO=humble
ARG BASE_CONTAINER=ros:$ROS_DISTRO-desktop
ARG ROOT_CONTAINER=$OWNER/$BASE_CONTAINER 

FROM $ROOT_CONTAINER
ENV PROJECT_DIR=/root/ws

USER root
RUN mkdir -p ${PROJECT_DIR}
COPY src ${PROJECT_DIR}/src
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${PROJECT_DIR}; colcon build --symlink-install'


RUN echo "source ${PROJECT_DIR}/install/setup.bash" >> /root/.bashrc

RUN echo 'ros2 run examples_rclcpp_minimal_subscriber subscriber_lambda' >> /root/.bash_history && \     
    echo 'ros2 run examples_rclcpp_minimal_publisher publisher_lambda' >> /root/.bash_history

WORKDIR ${PROJECT_DIR}
CMD /bin/bash
