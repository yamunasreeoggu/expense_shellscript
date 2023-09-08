source common.sh

echo Disabling MySQL 8
dnf module disable mysql -y >>$log_file

echo Placing MySQL repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo >>$log_file

echo Installing MySQL server
dnf install mysql-community-server -y >>$log_file

echo Starting MySQL server
systemctl enable mysqld >>$log_file
systemctl start mysqld >>$log_file

echo Setting root Password
mysql_secure_installation --set-root-pass ExpenseApp@1 >>$log_file