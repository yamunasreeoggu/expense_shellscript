log_file=/tmp/expense.log

download_and_extract() {
  echo Downloading $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file

  echo Extracting Frontend code
  unzip /tmp/$component.zip >>$log_file
}