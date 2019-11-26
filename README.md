# Dockerfiles with latest tensorflow version and gpu support


### How to use this repository

Follow the instructions from the official tensorflow repository:

```# Build the tools-helper image so you can run the assembler
$ docker build -t tf-tools -f tools.Dockerfile .

# Next you can make a handy alias depending on what you're doing. When building
# Docker images, you need to run as root with docker.sock mounted so that the
# container can run Docker commands. When assembling Dockerfiles, though, you'll
# want to run as your user so that new files have the right permissions.

# If you're BUILDING OR DEPLOYING DOCKER IMAGES, run as root with docker.sock:
$ alias asm_images="docker run --rm -v $(pwd):/tf -v /var/run/docker.sock:/var/run/docker.sock tf-tools python3 assembler.py "

# If you're REBUILDING OR ADDING DOCKERFILES, remove docker.sock and add -u:
$ alias asm_dockerfiles="docker run --rm -u $(id -u):$(id -g) -v $(pwd):/tf tf-tools python3 assembler.py "

# Assemble all of the Dockerfiles
$ asm_dockerfiles --release dockerfiles --construct_dockerfiles

# In order to build the image using latest tensorflow:
# Edit the only_tags_matching argument according to your preferences.
$ asm_images --release versioned --arg _TAG_PREFIX=2.0 --build_images --only_tags_matching="2.0-gpu-py3-jupyter"
```

### Running the image

After building, the image tag will be `tensorflow:2.0-gpu-py3-jupyter`, or similar depending on your preference.
Run the image using the following code. More information on the [docker documentation](https://docs.docker.com/engine/reference/run/):

```
$ docker run --runtime=nvidia -u $(id -u):$(id -g) -v $(pwd):/tf/notebooks -p 8888:8888 -it tensorflow:2.0-gpu-py3-jupyter
```




