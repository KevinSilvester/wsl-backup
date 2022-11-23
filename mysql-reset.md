# mysql-server Complete Re-Installation Steps
> ### Just in case I mess up again 🥲

*********************************************

1. Make sure MySQL isn't running and kill all running processes
   
```fish
# to stop process with sytemd init system
sudo systemctl stop mysql
      
# or stop without init system
sudo /etc/init.d/mysql stop

# On Linux
# if that doesn't work manually kill all running processes
ps -aux | awk '$1 == "mysql" {print $2}' | xargs -I % sudo kill -9 %

# On Windows
# open TaskManager and any processes names 'mysql' or 'mysqld'
```

2. Purge all of the MySQL packages
**On Ubuntu:**
```fish
sudo apt purge -y mysql-server
sudo apt autoremove -y

# alternatively use nala (a much better front-end for apt)
sudo nala purge -y mysql-server
sudo nala autoremove -y

# reconfigure dpkg
sudo dpkg --configure -a
```

3. Delete all related files
```fish
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql
```

4. Re-install mysql-server and dependencies

```fish
sudo nala update
sudo apt --fix-broken install
sudo nala install mysql-server -y
```

5. Pray that it doesn't mess up and check if it's installed

```fish
mysql --version
```

*********************************************

## Reset Root User Credentials
1. Start the database without loading the grant tables or enabling networking

```fish
# make sure to add '&' at the end to run process in background
sudo mysqld_safe --skip-grant-tables --skip-networking &
```

2. Login as root

```fish
mysql -u root
```

3. Once logged in, create a password for root user. 
   > - Using `caching_sha2_password` over `sha256_password` and `mysql_native_password` as it provides the best combination of security and performance.
   > - Use `mysql_native_password` if database is to be used with PHP application(e.g. phpMyAdmin) as `caching_sha2_password` is know to cause problems.

```fish
use mysql;
flush privileges;

ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'new_password';

flush privileges;
quit;
```

4. Kill the running process of mysql and start new instance

```fish
# find and kill running process
sudo /etc/init.d/mysql stop
ps -aux | awk '$12 == "mysqld_safe" {print $2}' | xargs -I % sudo kill -9 %

# start new process
sudo /etc/init.d/mysql start

# try login with new password
mysql -u root -p
```

5. Create a new default user
```fish
# sign in as root
mysql -u root -p

# create user
CREATE USER 'kevin'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'password';

# grant privileges
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'kevin'@'localhost' WITH GRANT OPTION;

flush privileges;
```

**For Windows**

6. Install mysql as service.
   Start and stop with `set net start MySQL`
```pwsh
# user elevation using gsudo
sudo 'mysqld --install MySQL --defaults-file="C:\Users\kevin\scoop\apps\mysql\current\my.ini"
```

<br></br>
> links/references:
> - <https://stackoverflow.com/questions/37879448/mysql-fails-on-mysql-error-1524-hy000-plugin-auth-socket-is-not-loaded>
> - <https://westonganger.com/posts/fix-mysql-error-1524-hy000-plugin-auth_socket-is-not-loaded-in-mysql-5-7>
> - <https://www.digitalocean.com/community/tutorials/how-to-reset-your-mysql-or-mariadb-root-password>
> - <https://stackoverflow.com/questions/41645309/mysql-error-access-denied-for-user-rootlocalhost>
> - <https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql>
> - <https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password>
