echo Placing NodeJS repo file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo Installing NOdeJS
dnf install nodejs -y

echo Copying backend.service file
cp backend.service /etc/systemd/system/backend.service

echo Adding Application user
useradd expense

echo Removing old app content
rm -rf /app
mkdir /app

echo Downloading backend code
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

cd /app
echo Extracting backend code
unzip /tmp/backend.zip

echo Installing dependencies
npm install

echo Staring backend service
systemctl daemon-reload
systemctl enable backend
systemctl start backend

echo Installing MySQL client
dnf install mysql -y

echo Load Schema
mysql -h mysql.yamunadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql