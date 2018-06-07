#!/bin/bash
set -e
echo "Enter you sudo Password"
sudo -l >> /tmp/shivam.logs


echo "Installing Important Software"
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install python-pip
sudo apt-get -y install vim
sudo apt-get -y install htop
sudo apt-get -y install git
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv
cd ~/Downloads/

echo "Installing Skype"
wget http://tel.red/linux.php?f=sky_2.1.6633-1ubuntu%2Bxenial_amd64.deb
sudo dpkg -i linux.php?f=sky_2.1.6633-1ubuntu%2Bxenial_amd64.deb 
sudo apt-get install -f

echo "Installing PyCharm"
wget https://download-cf.jetbrains.com/python/pycharm-community-2017.1.tar.gz
tar -xvf pycharm-community-2017.1.tar.gz
./pycharm-community-2017.1/bin/pycharm.sh

cd ~/Downloads/
echo "Installing Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb 
sudo apt-get install -f

mkdir -p ~/work/venvs
mkdir -p ~/work/projectss
mkdir -p ~/work/data

cd ~/work/venvs
echo "Cloning Telfa"
git clone https://github.com/litan/tefla

echo "Creating Virtual Env for Tefla"
cd ~/work/venvs
virtualenv --system-site-packages tefla-env
source ~/work/venvs/tefla-env/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade tensorflow
pip install --upgrade numpy
pip install -r ~/work/venvs/tefla/requirements.txt
deactivate

echo "Creating Virtual Env for NLP"
cd ~/work/venvs
virtualenv --system-site-packages nlp
source ~/work/venvs/nlp/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade tensorflow
pip install --upgrade keras
pip install --upgrade numpy
pip install --upgrade nltk
pip install --upgrade textblob
deactivate

echo "Installing Mongo"
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
#ADD -Y FOR AUTHENTICATING REPO TOO
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod 

echo "Installing Nginx"
sudo apt-get -y install nginx
sudo service nginx restart
sudo update-rc.d nginx defaults 

echo "Creating Symlinks for Virtual Env"
echo "
alias tefla_activate="source ~/work/venvs/tefla-env/bin/activate"
alias nlp_activate="source ~/work/venvs/nlp/bin/activate"
alias nagcoedl_activate="source ~/work/venvs/NAGCOEDL-env/bin/activate"
" >> ~/.bashrc

echo "Installing Redis"
sudo apt-get install build-essential
sudo apt-get install tcl8.5
cd ~/Downloads/
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
cd utils
sudo ./install_server.sh
sudo service redis_6379 start
sudo update-rc.d redis_6379 defaults

cd ~/work/venvs
echo "Cloning NAGCOEDL"
git clone https://git.nagarro.com/root/NAGCOEDL.git
virtualenv --system-site-packages NAGCOEDL-env
source ~/work/venvs/NAGCOEDL-env/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
pip install -r ~/work/venvs/NAGCOEDL/Project/CSX/CarTypeProblem/cvmldemo/requirements-tefla.txt
pip install -r ~/work/venvs/NAGCOEDL/Project/CSX/CarTypeProblem/cvmldemo/requirements.txt
deactivate
