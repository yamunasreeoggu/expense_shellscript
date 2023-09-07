echo Installing Nginx
dnf install nginx -y >>/tmp/expense.log

echo Placing Expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>/tmp/expense.log

echo Removing Nginx Default content
rm -rf /usr/share/nginx/html/* >>/tmp/expense.log

echo Downloading Frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>/tmp/expense.log

cd /usr/share/nginx/html

echo Extracting Frontend code
unzip /tmp/frontend.zip >>/tmp/expense.log

echo Restarting Nginx
systemctl enable nginx >>/tmp/expense.log
systemctl restart nginx >>/tmp/expense.log