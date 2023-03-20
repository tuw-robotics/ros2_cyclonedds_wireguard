ARG OWNER=osrf
ARG ROS_DISTRO=humble
ARG BASE_CONTAINER=ros:$ROS_DISTRO-desktop
ARG ROOT_CONTAINER=$OWNER/$BASE_CONTAINER 

FROM $ROOT_CONTAINER
ENV PROJECT_DIR=/root/ws

USER root

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y  iproute2 vim \
        ros-$ROS_DISTRO-rmw-fastrtps-cpp \
        ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
        ros-$ROS_DISTRO-rmw-gurumdds-cpp;

RUN mkdir -p ${PROJECT_DIR}
COPY src ${PROJECT_DIR}/src

RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${PROJECT_DIR}; colcon build --symlink-install'

RUN apt-get autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

COPY cyclonedds.xml ${PROJECT_DIR}/cyclonedds.xml
COPY env.sh ${PROJECT_DIR}/env.sh 

RUN echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc 

RUN echo 'echo $RMW_IMPLEMENTATION' >> /root/.bash_history && \     
    echo 'echo $CYCLONEDDS_URI' >> /root/.bash_history && \     
    echo 'ros2 run examples_rclcpp_minimal_subscriber subscriber_lambda' >> /root/.bash_history && \     
    echo 'ros2 run examples_rclcpp_minimal_publisher publisher_lambda' >> /root/.bash_history

WORKDIR ${PROJECT_DIR}
CMD /bin/bash
