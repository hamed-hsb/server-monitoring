#!/bin/bash


url_address=""
email_address=""
timer=""


function main(){
if  existsConfigFile $0 ; then
# Config file is not found
createConfigFile
init
else
# Config file is the directory
run
fi
}

function init(){
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

function run(){
echo "run function"
readConfigFile
execute $url_address $timer
}

function existsConfigFile(){
if [ ! -f sm.config ]; then
return 0;
else
return 1;
fi
}


function createConfigFile(){
if existsConfigFile $0 ; then
# Config file is not found
touch sm.config
fi
}

function saveConfigToFile(){
cat << EOF > sm.config
URL_ADDRESS:$1
EMAIL_ADDRESS:$2
TIMER:$3
EOF
}

function readConfigFile(){
while IFS= read -r line
do

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

function spliteRowValue(){
echo "$2"
}

function checkUrlHttpStatusCode(){
status=$(curl --write-out '%{http_code}' --silent --output /dev/null $1)
echo $status
}


function execute(){
for((;;))
do
response=$(checkUrlHttpStatusCode $1)
current_date_time="`date +%Y%m%d%H%M%S`"
echo "time: $current_date_time url: $1 status: $response"
sleep $2s
done
}


main


