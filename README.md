# ros-indigo-baxter-vnc

Docker image for ROS Indigo with Baxter SDK, Gazebo, MoveIt and VNC access.

## Getting Started

### Create volume to bind ROS workspace

```bash
docker volume create --driver local \
    --opt type=none \
    --opt device=/local/path \
    --opt o=bind \
    ros_vol
```

**Note** Any files you create in your volume (aka path directory) will get stored onto your local filesytem with root permissions. While this is nice since you have access to all of your created files now, it is recommended you create files locally so `docker` can see them and load them accordingly without the permissions messiness.

### Run the Container

#### Working only with Gazebo

```bash
docker run -it \
    --env="DISPLAY" \
    -p 6080:80 \
    -p 5900:5900 \
    -v ros_vol:/root/ros_ws \
    agutf/ros-indigo-baxter-vnc
```

#### Working with real Baxter

```bash
docker run -it \
    --env="DISPLAY" \
    --net=host \
    -v ros_vol:/root/ros_ws \
    agutf/ros-indigo-baxter-vnc
```

### Access the Container GUI

#### Container launched with port binding

Go to [http://127.0.0.1:6080/](http://127.0.0.1:6080/) and access the web based GUI where you should be able to work like normal.

In case you wish to use the VNC client and can get it set up on your machine (which shouldn't be hard), you can enter the server address `0.0.0.0:5900` in the client and access the container.

#### Container launched with --net=host

Go to [http://localhost](http://localhost) and access the web based GUI where you should be able to work like normal.

### Acknowledgments

Image based on [varunagrawal/ros-indigo-fetch-vnc](https://github.com/varunagrawal/ros-indigo-fetch-vnc)