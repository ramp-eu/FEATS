FROM ros:melodic-ros-base

RUN mkdir catkin_ws \
    && mkdir catkin_ws/src \
    && mkdir catkin_ws/src/feats-simulator \
    && mkdir catkin_ws/devel \
    && mkdir catkin_ws/build

COPY ./feats-simulator /catkin_ws/src/feats-simulator
WORKDIR /catkin_ws

RUN apt-get update -qq --allow-insecure-repositories && \
  apt-get install -y ros-melodic-tf python-twisted python-autobahn python-tornado python-bson python-pip --allow-unauthenticated

RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make'

#CMD /bin/bash -c ' . /opt/ros/melodic/setup.bash; . /catkin_ws/devel/setup.bash; rosrun feats_simulator main.py'
