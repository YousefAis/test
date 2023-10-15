sudo apt install postgresql-10 # version 10
sudo -u postgres createuser odoo11 --interactive -p 5432
sudo mkdir /opt/odoo
sudo chown root:odoo /opt/odoo
git clone -b 11.0 git@github.com:odoo/odoo.git /opt/odoo/odoo11
sudo chown -hR root:odoo /opt/odoo/odoo11
sudo apt update; sudo apt dist-upgrade

sudo apt install make build-essential libreadline-dev \
wget curl llvm libssl-dev zlib1g-dev libbz2-dev  \
libsqlite3-dev libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev libgdbm-dev \
libnss3-dev libedit-dev libc6-dev

wget https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz

tar -xzf Python-3.6.15.tgz
cd Python-3.6.15
./configure --enable-optimizations --with-lto --with-pydebug
make -j 2  

sudo make altinstall

python3.6 -V

sudo apt install python3-pip

sudo mkdir -p /python-venv/3.6/odoo11

sudo chown -hR odoo11: /python-venv/3.6/odoo11

sudo su - odoo11 -s /bin/bash

python3.6 -m venv /python-venv/3.6/odoo11

sudo apt install libjpeg-dev libjpeg-turbo8-dev \
libjpeg8-dev libldap-dev libldap2-dev libpq-dev \
libsasl2-dev libxslt1-dev

sudo apt install nodejs

sudo apt install npm

sudo npm install -g npm

sudo npm install -g less@3.10.3
sudo npm install -g less-plugin-clean-css

wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb

sudo dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb
# force install dependencies
sudo apt -f install

# switch to odoo11's bash
sudo su - odoo11 -s /bin/bash
# activate the virtual environment
source /python-venv/3.6/odoo11

pip install --upgrade pip

pip install -r /opt/odoo/odoo11/requirements.txt

/opt/odoo/odoo11/odoo-bin

/opt/odoo/odoo11/odoo-bin --xmlrpc-port=8089

# Deactivate the virtual environment
deactivate
# exit odoo11's bash session to get back the previous unix user
exit



