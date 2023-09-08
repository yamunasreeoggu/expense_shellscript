echo Installing Nginx
dnf install nginx -y

echo Placing Expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf

echo Removing Nginx default content
rm -rf /usr/share/nginx/html/*

echo Downloading Frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

echo Extracting Frontend code
unzip /tmp/frontend.zip

echo Restarting Nginx
systemctl enable nginx
systemctl restart nginx