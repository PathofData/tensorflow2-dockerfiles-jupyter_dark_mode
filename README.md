# Dockerfiles with latest tensorflow version and gpu support with jupyter dark mode enabled by default

This repository contains dockerfiles that build tensorflow using the methodology proposed in the official tensorflow repository, together with dark mode for jupyter notebook and some popular ML packages (pandas, matplotlib, scikit-learn). Graphviz and pydot packages are also installed since they are required for model visualization.

#### Pulling the image from docker hub
A pre built image using the tools found in this repository has been uploaded to docker hub. 
One can pull it using the following command:

```
$ docker pull pathofdata/tensorflow:2.0-gpu-py3-jupyter
```

#### Building the image locally

Follow the instructions from the official tensorflow repository:

```
# Build the tools-helper image so you can run the assembler
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
If you have pulled the image its name will be `pathofdata/tensorflow:2.0-gpu-py3-jupyter`.
Run the image using the following code. More information on the [docker documentation](https://docs.docker.com/engine/reference/run/):

```
$ docker run --runtime=nvidia -u $(id -u):$(id -g) -v $(pwd):/tf/notebooks -p 8888:8888 -it tensorflow:2.0-gpu-py3-jupyter
```

If your docker version is >= 19.03 and you have nvidia-container-toolkit [installed](https://github.com/NVIDIA/nvidia-docker) then use the following command:

```
$ docker run --gpus all -u $(id -u):$(id -g) -v $(pwd):/tf/notebooks -p 8888:8888 -it tensorflow:2.0-gpu-py3-jupyter
```

Keep in mind that in order for the dark theme to apply (and every time you need to switch themes) you have to run the image as root by removing the `-u $(id -u):$(id -g)` arguments.

Jupyter notebook uses its dark theme from the package called [jupyterthemes](https://github.com/dunovank/jupyter-themes).

