source common.sh

echo Disabling MySQL 8
dnf module disable mysql -y &>>$log_file
status_check

echo Placing MySQL repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo Installing MySQL server
dnf install mysql-community-server -y &>>$log_file
status_check

echo Starting MySQL server
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
status_check

echo Setting root Password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
status_check