# mysql-server Complete Re-Installation Steps

> ### Just in case I mess up again 🥲

*********************************************

1. Make sure MySQL isn't running and kill all running processes
   
```fish
# try this first
sudo systemctl stop mysql

# if that doesn't work
sudo ps -aux  

# to view all running processes
# then kill all mysql process by PID
kill -9 {PID}
```

2. Purge all of the MySQL packages

```fish
# since wildcard doesn't work in fish (and I'm too lazy to find out how to it properly 😁)
bash -c "sudo apt purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*"

# remove all MySQL files
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql

# remove all packages that are not needed
sudo apt autoremove
sudo apt autoclean

# reconfigure dpkg
sudo dpkg --configure -a
```

3. Re-install mysql-server and dependencies

```fish
sudo apt update
sudo apt --fix-broken install
sudo apt-get --reinstall install mysql-client-core-8.0 -y
sudo apt install mysql-server -y
```

4. Pray that it doesn't mess up and check if it's installed

```fish
mysql --version
```
