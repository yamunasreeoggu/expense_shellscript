source common.sh
component=backend

echo Placing NodeJS repo file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

echo Installing NOdeJS
dnf install nodejs -y &>>$log_file

echo Copying backend.service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo Adding Application user
useradd expense &>>$log_file

echo Removing old app content
rm -rf /app &>>$log_file
mkdir /app
cd /app

download_and_extract

echo Installing dependencies
npm install &>>$log_file

echo Staring backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo Installing MySQL client
dnf install mysql -y &>>$log_file

echo Load Schema
mysql -h mysql.yamunadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file