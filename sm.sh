#!/bin/bash

echo "Start Config..."
read -p "Enter Website/Domain name: " URL_ADD
read -p "Enter your email: " EMAIL_ADD
echo "\n \n \n "
echo "Your Website/Domain is : $URL_ADD"
echo "Your Email address is : $EMAIL_ADD"



function main(){

}

function init(){
}

function existsConfigFile(){
	
}

function createConfigFile(){
	if [ ! -f sm.config ]; then
	# Config file is not found
	touch sm.config
	fi
}

function saveConfigToFile(){
	cat << EOF > sm.config
	URL_ADDRESS: $URL_ADD
	EMAIL_ADDRESS: $EMAIL_ADD
	EOF
}
