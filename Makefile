PROJECT_DIR = $(shell pwd)
SHELL = /bin/bash
HOSTNAME := $(shell hostname)
PREFIX = ros2_cyclonedds_wg

all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make clean            - removes install, build, log"
	@echo "   make build            - builds develop"
	@echo "   make docker-build     - builds a docker image"
	@echo "   make docker-run       - runs the docker image"
	@echo ""

clean: 
	rm -rf ./install ./build  ./log

build: 
	source /opt/ros/${ROS_DISTRO}/setup.bash; \
	colcon build --symlink-install

docker-build:
	@docker build --rm -t ${PREFIX}-${ROS_DISTRO} -f Dockerfile  .

docker-run:
	@docker run -ti --rm --network="host" ${PREFIX}-${ROS_DISTRO}

docker-run-extras:
	@docker run -ti --rm  \
	    --network="host" \
	    --add-host "${PREFIX}-${HOSTNAME}:127.0.0.1" \
	    --hostname ${PREFIX}-${HOSTNAME} \
	    --name ${PREFIX}-${HOSTNAME} \
		${PREFIX}-${ROS_DISTRO}