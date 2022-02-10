# PHP Setup
### With composer

*****************************************************

## Install PHP
```fish
# make sure all packages are up to date
sudo apt update && sudo apt upgrade

# install repo with all version of php
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

# install v7.4 and Apache 2 with its dependencies
sudo apt -y install php7.4 libapache2-mod-php

# check if installed
php -v

# install some common modules
sudo apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath
```

*****************************************************

## Install composer
```bash
# change shell to bash
bash

# update packages
sudo apt update && sudo apt upgrade

# install unzip
sudo apt install unzip

# download composer
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

# get SHA-384 hash for the latest installer from https://composer.github.io/pubkeys.html
# to verify the downloaded installer and store as a variable
HASH=`curl -sS https://composer.github.io/installer.sig`

# check hash
echo $HASH

# verify that the installation script is safe to run
# from the composer dowload page https://getcomposer.org/download/
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

# to install composer globally
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

******************************************************

### References
> - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-composer-on-ubuntu-20-04
> - https://www.digitalocean.com/community/tutorials/how-to-install-php-7-4-and-set-up-a-local-development-environment-on-ubuntu-20-04
> - https://getcomposer.org/download/
