source common.sh

echo Placing NodeJS repo file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file

echo Installing NOdeJS
dnf install nodejs -y >>$log_file

echo Copying backend.service file
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo Adding Application user
useradd expense >>$log_file

echo Removing old app content
rm -rf /app >>$log_file
mkdir /app

echo Downloading backend code
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>$log_file

cd /app
echo Extracting backend code
unzip /tmp/backend.zip >>$log_file

echo Installing dependencies
npm install >>$log_file

echo Staring backend service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo Installing MySQL client
dnf install mysql -y >>$log_file

echo Load Schema
mysql -h mysql.yamunadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file