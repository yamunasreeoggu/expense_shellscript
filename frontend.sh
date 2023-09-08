source common.sh

echo Installing Nginx
dnf install nginx -y >>$log_file

echo Placing Expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo Removing Nginx default content
rm -rf /usr/share/nginx/html/* >>$log_file

echo Downloading Frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html

echo Extracting Frontend code
unzip /tmp/frontend.zip >>$log_file

echo Restarting Nginx
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file