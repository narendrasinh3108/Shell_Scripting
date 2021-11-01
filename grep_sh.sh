#!/bin/bash

read -p "Enter File Name: " fname
echo -e $fname

function seperator(){
   echo "###########################################"
}

function start(){
	GREEN='\033[0;32m'
	NC='\033[0m'
	echo $1
        echo -e "${GREEN}"
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
      echo "5) Search multiple String"
      echo "6) Print first N Number's line" 
      echo "7) print last N Number's line"
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
	 5) str=''
	    while true
	    do
              read -p "Enter String: " str1
	      if [ -z $str ]
              then
		 str=$str1
		 continue
	      else 
	      	 str="$str|$str1"
	      fi
	      read -p "add more y/n: " ans
	      if [ $ans = 'n' ]
	      then
		  break
	      fi
            done
	    start "grep -Ei $str $fname"
	    ;;
	 6) read -p "Enter N value: " val
	    start "head -n $val $fname "
	    ;;
         7) read -p "Enter N value: " val
	    start "tail -n $val $fname" 
            ;;
         *) break ;;
      esac 
done
