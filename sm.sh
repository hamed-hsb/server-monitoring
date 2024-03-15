#!/bin/bash


url_address=""
email_address=""
timer=""

CONFIG_FILE_NAME="sm.config"
LOG_FILE_NAME="sm.log"


main(){
if  existsConfigFile $0 ; then
# Config file is not found
createConfigFile
fi

if existsLogsDirectory $0 ; then
createLogsdirectory
fi

if existsLoggerFile $0 ; then
createLoggerFile
fi

init
#else
# Config file is the directory
#run
#fi
}

init(){
echo "Start Config..."
read -p "Enter Website/Domain name: " URL_ADD
read -p "Enter your email: " EMAIL_ADD
read -p "Enter a number between [1 to 60], to repeat the task, this number is based on seconds: " TIMER
echo "\n \n \n "
echo "Your Website/Domain is : $URL_ADD"
echo "Your Email address is : $EMAIL_ADD"
echo "Your Email address is : $TIMER"



saveConfigToFile $URL_ADD  $EMAIL_ADD $TIMER
}

run(){
echo "Start..."
echo "Address:$url_address"

readConfigFile
execute $url_address
}

existsConfigFile(){
if [ ! -f $CONFIG_FILE_NAME ]; then
return 0;
else
return 1;
fi
}

existsLoggerFile(){
LOG_FILE_NAME="`date +%Y%m%d`.log"
if [ ! -f $LOG_FILE_NAME ]; then
return 0;
else 
return 1;
fi
}

existsLogsDirectory(){
DIR="`pwd`/logs"
if [ -d "$DIR" ]; then
return 1;
else
return 0;
fi
}

createLogsdirectory(){
mkdir logs
}
createLoggerFile(){
cd logs
LOG_FILE_NAME="`date +%Y%m%d`.log"
if existsLoggerFile $0 ; then
touch $LOG_FILE_NAME
fi
}

insertToLoggerFile(){
echo "`date` url:$1  Code:$2 ."$'\n' >> $LOG_FILE_NAME
}

createConfigFile(){
if existsConfigFile $0 ; then
# Config file is not found
touch $CONFIG_FILE_NAME
fi
}

saveConfigToFile(){
cat << EOF > sm.config
URL_ADDRESS: $1
EMAIL_ADDRESS: $2
TIMER: $3
EOF
}

readConfigFile(){
while IFS= read -r line
do

#echo $line
	if [[ $line == *"URL_ADDRESS"* ]];then
	url_address=$line
	url_address=$(spliteRowValue $url_address)
	fi 

	if [[ $line == *"EMAIL_ADDRESS"*  ]]; then
	email_address=$line
	email_address=$(spliteRowValue $email_address)
	fi

	if [[ $line == *"TIMER"*  ]]; then
	timer=$line
	timer=$(spliteRowValue $timer)
	fi

done < sm.config
}

spliteRowValue(){
echo $2
}

checkUrlHttpStatusCode(){
status=$(curl --write-out '%{http_code}' --silent --output /dev/null $1)
echo $status
}


execute(){
for((;;))
do
response=$(checkUrlHttpStatusCode $1)
current_date_time="`date +%Y%m%d%H%M%S`"
echo "time: $current_date_time url: $1 status: $response"
sleep 60
insertToLoggerFile $1 $response
done
}


main


