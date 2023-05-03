set -ex

# clone chipyard
#git clone                                     \
#  git@github.com:paragon-lab/chipyard.git     \
#  --depth 1 #don't need long commit history 

# Dependencies

# VERILATOR:
#apt install verilator
# If you don't already have Verilator installed:  
# There's definitely a fancy way to do this, but that's a future Connor problem. 
  # git clone http://git.veripool.org/git/verilator
  # cd verilator
  #git checkout v4.224
  #autoconf && ./configure --prefix="$HOME/verilator-v4.224-install" && make -j$(nproc) && make install
  #echo "export PATH=$HOME/verilator-v4.224-install/bin:$PATH" >> "$HOME/.bashrc"

#\\\\\\\\\\\\\\\\\\\\\\host dependencies\\\\\\\\\\\\\\\\\\\\\\\\ 
sudo apt-get update
sudo apt-get install -y build-essential 
sudo apt-get install -y bison 
sudo apt-get install -y flex
sudo apt-get install -y software-properties-common 
sudo apt-get install -y libgmp-dev 
sudo apt-get install -y libmpfr-dev
sudo apt-get install -y libmpc-dev
sudo apt-get install -y zlib1g-dev
#need openjdk 17
sudo apt install -y openjdk-17-jdk

#install sbt: https://www.scala-sbt.org/release/docs/Installing-sbt-on-Linux.html#Ubuntu+and+other+Debian-based+distributions
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get install -y sbt
sudo apt-get install -y texinfo
sudo apt-get install -y gengetopt
sudo apt-get install -y libexpat1-dev
sudo apt-get install -y libusb-dev
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y cmake 
#deps for poky
sudo apt-get install -y python3
sudo apt-get install -y patch
sudo apt-get install -y diffstat
sudo apt-get install -y texi2html
sudo apt-get install -y subversion
sudo apt-get install -y chrpath
sudo apt-get install -y wget
#deps for qemu
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y gettext
#deps for firemarshal
sudo apt-get install -y python3-pip 
sudo apt-get install -y python3.8-dev 
sudo apt-get install -y rsync
sudo apt-get install -y libguestfs-tools
sudo apt-get install -y expat
#sudo apt-get install ctags #didn't work in migration to tt_cy
#install DTC
sudo apt-get install -y device-tree-compiler
echo "dependencies installed!"


# For to build GCC sans errors 
unset LD_LIBRARY_PATH

# Specify multithreading 
export MAKEFLAGS="-j8"

# Push Chipyard directory onto stack, cd into folder
pushd chipyard 
    # Initialize Submodules (gross)
    ./scripts/init-submodules-no-riscv-tools.sh
    #build the toolchain
    ./scripts/build-toolchains.sh esp-tools
popd #pop cy directory from stack, cd back to top of stack
