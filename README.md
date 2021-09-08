# GrootDocker

<h1 align="center">🌳 Groot Docker 🐋</h1>
<p align="center">Docker configurations for Groot, the BehaviourTrees graphical editor</p>

## 🎈 Intro

This is a Docker image build around [Groot](https://github.com/BehaviorTree/Groot).

## 📦 Dependencies

As a docker image, it is necessary to have docker installed, for instructions on how to do that, see the [oficial documentation](https://docs.docker.com/engine/install/).

The best way to run this image is with [rocker](https://github.com/osrf/rocker), ROS custom docker runner.

If you have ROS repos configured in your computer (see [here](http://wiki.ros.org/noetic/Installation/Ubuntu#Installation.2FUbuntu.2FSources.Configure_your_Ubuntu_repositories) how to do that), you may install `rocker` with the command

```bash
sudo apt-get install python3-rocker
```

If you don't have the ROS repos or you don't use a Debian-based distro, you may also install `rocker` with `pip`

```bash
python -m pip install rocker
```

## 🔨 Building

There as two ways of building this docker image, using docker BuildKit or not.

To simlpy build the image, run in the root of the repository:

```bash
docker build . -t thunderatz/groot
```

To use the BuildKit to build the image, set the `DOCKER_BUILDKIT=1` environment variable when invoking the `docker build`, such as:

```bash
DOCKER_BUILDKIT=1 docker build . -t thunderatz/groot
```

## 🏁 Running

First, to be able to execute graphical applications with docker, run:

```bash
xhost +local:docker
```

### 🤖 rocker

For Intel integrated graphics cards:

```bash
rocker --devices /dev/dri/card0 --x11 --network host thunderatz/groot:latest
```

For NVidia GPUs:

```bash
rocker --nvidia --x11 --network host thunderatz/groot:latest
```

### 🐋 docker

Running on linux:

```bash
docker run -it --rm \
    --env="DISPLAY" \
    --env="TERM" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=/tmp/.docker.xauth" \
    --volume /tmp/.docker.xauth:/tmp/.docker.xauth \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    thunderatz/groot:latest
```
