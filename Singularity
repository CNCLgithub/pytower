Bootstrap: docker
From: ubuntu:18.04


%setup

 if [ -d ${SINGULARITY_ROOTFS}/mybin ];then
    rm -r ${SINGULARITY_ROOTFS}/mybin
 fi

 if [ -d ${SINGULARITY_ROOTFS}/blender ];then
     rm -r ${SINGULARITY_ROOTFS}/blender
 fi

%files
 bin /mybin
 blender.tar.bz2 /blender.tar.bz2

%environment
 export PATH=$PATH:/mybin/
 export PATH=$PATH:/blender/blender
 export PATH=$PATH:/miniconda/bin

 export LANG=en_US.UTF-8
 export TMPDIR=$PWD/.tmp

 if [ -d ${PWD}/.tmp ];then
    rm -rf ${PWD}/.tmp
 fi
 mkdir ${PWD}/.tmp

%runscript
  exec bash "$@"

%post
 apt-get update
 apt-get install -y  build-essential \
                     graphviz \
                     git \
                     wget \
                     ffmpeg \
                     libglu1 \
                     libxi6
 apt-get clean

 # Setup /mybin
 chmod +x /mybin/*

 # Setup blender
 tar xvjf /blender.tar.bz2
 rm /blender.tar.bz2
 mv blender-2.79* /blender
 chmod +x blender/blender

 # Setup conda
 wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
 bash conda.sh -b -p /miniconda
 rm conda.sh
 
