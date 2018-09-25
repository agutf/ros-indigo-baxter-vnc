# ros-indigo-fetch-vnc
Docker image for ROS Indigo with Fetch Gazebo and VNC access.

## Getting Started

### Pull the Docker Image

Simply run
```bash
docker pull -t varunagrawal/ros-indigo-fetch-vnc:latest .
```

The image should have everything you need to run the Fetch robot in Gazebo.

### Run the Container

```bash
docker run -it \
    --env="DISPLAY" \
    --workdir="/home/$USER" \
    --volume="/home/$USER:/home/$USER" \
    -p 6080:80 -p 5900:5900 \
    varunagrawal/ros-indigo-fetch-vnc:latest
```
**Note** Any files you create in your volume (aka path directory) will get stored onto your local filesytem with root permissions. While this is nice since you have access to all of your created files now, it is recommended you create files locally so `docker` can see them and load them accordingly without the permissions messiness.

### Access the Container GUI

Go to [http://127.0.0.1:6080/](http://127.0.0.1:6080/) and access the web based GUI where you should be able to work like normal.

In case you wish to use the VNC client and can get it set up on your machine (which shouldn't be hard), you can enter the server address `0.0.0.0:5900` in the client and access the container.

#### Acknowledgments

Thanks to Ruffin White (previously at Georgia Tech, now at UCSD) for writing up a great tutorial on using the GUI with docker for ROS.

Also thanks to Christian Henkel for setting up the base ROS+VNC image on which this image is based.
