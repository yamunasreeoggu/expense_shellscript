source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y &>>$log_file
status_check

echo Placing Expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check

echo Removing Nginx default content
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check

cd /usr/share/nginx/html

download_and_extract

echo Starting Nginx
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check