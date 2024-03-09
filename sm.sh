#!/bin/bash





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
echo "\n \n \n "
echo "Your Website/Domain is : $URL_ADD"
echo "Your Email address is : $EMAIL_ADD"
	
saveConfigToFile $URL_ADD  $EMAIL_ADD
}

function run(){
echo "run function"
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
URL_ADDRESS: $1
EMAIL_ADDRESS: $2
EOF
}



main


