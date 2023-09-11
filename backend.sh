source common.sh
component=backend

type npm &>>log_file
if [ $? -ne 0 ]; then
  echo Install NodeJS repo file
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  status_check

  echo Installing NOdeJS
  dnf install nodejs -y &>>$log_file
  status_check
fi

echo Copying backend.service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check

echo Adding Application user
id expense &>>$log_file
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
status_check

echo Removing old app content
rm -rf /app &>>$log_file
status_check

mkdir /app
cd /app

download_and_extract

echo Download dependencies
npm install &>>$log_file
status_check

echo Staring backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check

echo Installing MySQL client
dnf install mysql -y &>>$log_file
status_check

echo Load Schema
mysql_root_password=$1
mysql -h mysql.yamunadevops.online -uroot -p$mysql_root_password < /app/schema/backend.sql &>>$log_file
status_check
