echo -e "\n---- install postgresql-10 ----"
sudo apt -y install postgresql-10 # version 10
echo -e "\n---- createuser ----"
sudo -u postgres createuser odoo11 --interactive -p 5432
sudo mkdir /opt/odoo
sudo chown root:odoo /opt/odoo

echo -e "\n---- Clone odoo 11 ----"
git clone -b 11.0 https://github.com/odoo/odoo.git /opt/odoo/odoo11
echo -e "\n---- 1 ----"
sudo chown -hR root:odoo /opt/odoo/odoo11
echo -e "\n----2 ----"
sudo apt update; sudo apt dist-upgrade

echo -e "\n---- python 3.6 ----"

sudo apt -y install make build-essential libreadline-dev \
wget curl llvm libssl-dev zlib1g-dev libbz2-dev  \
libsqlite3-dev libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev libgdbm-dev \
libnss3-dev libedit-dev libc6-dev


wget https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz
echo -e "\n---- Clone odoo 11 ----"

tar -xzf Python-3.6.15.tgz
cd Python-3.6.15
./configure --enable-optimizations --with-lto --with-pydebug
make -j 2  

echo -e "\n----  altinstall ----"
sudo make altinstall

python3.6 -V

echo -e "\n---- python3-pip ----"
sudo apt -y install python3-pip
echo -e "\n---- 3 ----"
sudo mkdir -p /python-venv/3.6/odoo11

sudo chown -hR odoo11: /python-venv/3.6/odoo11
echo -e "\n---- 4 ----"
sudo su - odoo11 -s /bin/bash
echo -e "\n---- 5 ----"
python3.6 -m venv /python-venv/3.6/odoo11

echo -e "\n----  python dep ----"

sudo apt -y install libjpeg-dev libjpeg-turbo8-dev \
libjpeg8-dev libldap-dev libldap2-dev libpq-dev \
libsasl2-dev libxslt1-dev

echo -e "\n---- nodejs ----"
sudo apt -y install nodejs

echo -e "\n----  npm ----"
sudo apt -y install npm

sudo npm -y install -g npm

echo -e "\n----less ----"
sudo npm -y install -g less@3.10.3
sudo npm -y install -g less-plugin-clean-css

echo -e "\n---- 6 ----"
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
echo -e "\n---- 7 ----"
sudo dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb
# force install dependencies
sudo apt -f install
echo -e "\n---- 8 ----"
# switch to odoo11's bash
sudo su - odoo11 -s /bin/bash
# activate the virtual environment
source /python-venv/3.6/odoo11
echo -e "\n---- 9 ----"
pip install --upgrade pip
echo -e "\n---- 10 ----"
pip install -r /opt/odoo/odoo11/requirements.txt

/opt/odoo/odoo11/odoo-bin

/opt/odoo/odoo11/odoo-bin --xmlrpc-port=8089

# Deactivate the virtual environment
deactivate
# exit odoo11's bash session to get back the previous unix user
exit



