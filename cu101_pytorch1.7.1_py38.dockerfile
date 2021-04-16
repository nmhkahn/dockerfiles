FROM nvidia/cuda:10.1-devel-ubuntu18.04
WORKDIR /root

RUN apt-get -qq update && \
    apt-get -qq install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get -qq install -y build-essential python3.8 python3.8-dev python3-pip && \
    python3.8 -m pip install pip --upgrade && \
    python3.8 -m pip install wheel

RUN ln -s `which python3.8` /usr/bin/python && \
    rm /usr/bin/python3-config && \
    ln -s `which python3.8-config` /usr/bin/python3-config

RUN apt-get -qq install -y \
    wget curl \
    autoconf automake libtool make g++ unzip \
    ninja-build \
    libsm6 libxext6 libxrender-dev \
    libgl1-mesa-glx

COPY libcudnn8_8.0.5.39-1+cuda10.1_amd64.deb /root/libcudnn8_8.0.5.39-1+cuda10.1_amd64.deb
RUN dpkg -i libcudnn8_8.0.5.39-1+cuda10.1_amd64.deb
RUN rm libcudnn8_8.0.5.39-1+cuda10.1_amd64.deb

RUN pip install \
    six wheel setuptools \
    ninja numpy scipy fire h5py \
    tqdm munch pyyaml pillow scikit-image \
    ftfy regex click pyspng imageio-ffmpeg==0.4.3

RUN pip install torch==1.7.1+cu101 torchvision==0.8.2+cu101 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
