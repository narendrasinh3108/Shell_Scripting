#!/bin/bash

read -p "Enter File Name: " fname
echo -e $fname

function seperator(){
   echo "###########################################"
}
function start(){
	GREEN='\033[0;32m'
	NC='\033[0m'
        echo -e "${GREEN}}"
	seperator
	$1
	seperator
	echo -e "${NC}"
        
}

while true
do
      echo "1) Serch text from file"
      echo "2) Count the number of match string"
      echo "3) Search whole words in file"
      echo "4) Inverting the match string"
      echo "*) Exit" 
      read -p "Choose: " ch
      
      case $ch in
         1) read -p "Enter string: " str
	    start "grep -i $str $fname"
	    ;; 
	 2) read -p "Enter string: " str
	    start "grep -c $str $fname"
	    ;;
	 3) read -p "Enter String: " str
            start "grep -w $str $fname"
            ;;
	 4) read -p "Enter String: " str
	    start "grep -v $str $fname"
	    ;;
         *) break ;;
      esac 
done
