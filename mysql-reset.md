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

*********************************************

## Reset Root User Credentials
1. Start the database without loading the grant tables or enabling networking

```fish
sudo mysqld_safe --skip-grant-tables --skip-networking &
```

2. Login as root

```fish
mysql -uroot
```

3. Once logged in, paste following commands into the mysql cli

```fish
use mysql;
flush privileges;
update user set plugin="mysql_native_password";

ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';

flush privileges;
quit;
```

4. Kill the running process of mysql and start new instance

```fish
# find and kill running process
sudo ps -aux
sudo kill -9 {PID}

# start new process
sudo /etc/init.d/mysql start

# try login with new password
mysql -u root -p
```

> links for further help
> - <https://stackoverflow.com/questions/37879448/mysql-fails-on-mysql-error-1524-hy000-plugin-auth-socket-is-not-loaded>
> - <https://westonganger.com/posts/fix-mysql-error-1524-hy000-plugin-auth_socket-is-not-loaded-in-mysql-5-7>
> - <https://www.digitalocean.com/community/tutorials/how-to-reset-your-mysql-or-mariadb-root-password>
> - <https://stackoverflow.com/questions/41645309/mysql-error-access-denied-for-user-rootlocalhost>
