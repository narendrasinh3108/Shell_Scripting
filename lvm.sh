while true
do
	echo "(1) display Physicals Volumes(PV)"
        echo "(2) display Volume Groups(VG)"
	echo "(3) display Logical volume(LVM)"
	echo "(4) create Physicals Volumes(PV)"
	echo "(5) create Virtual Groups(VG)"
	echo "(*) Exits"
	read -p "Choose: " choose

	case $choose in
           1) sudo pvdisplay
	      ;;
	   2) sudo vgdisplay
	      ;;
	   3) sudo lvdisplay
              ;;
           4) # variable "a" store disk name which are not mounted
	      a=$(lsblk --noheading -r -o NAME,TYPE,MOUNTPOINT | awk '$1~/[[:alnum:]]/ && $2 == "disk" && $3 == ""' | sed 's/disk//') 
              # variable "b" store already created physical volume name
	      b=$(sudo pvdisplay | grep -o "/dev.*" | sed 's/dev//' | tr -d /)
	      echo $a
	      echo $b
	      c=" "
	  
	      # remove already available physical volume disk name from variable "a"
	      for i in $a
              do
		  counter=0
                  for j in $b
	          do
	               if [ $i = $j ]
		       then 
			   counter=1
		       fi
	          done
		  if [ $counter = 0 ]
	          then
                     lsblk /dev/$i
	          fi
	      done
	          while true
	          do
	            read -p "select your drive " drive
	            drive="/dev/$drive"
	            echo $drive	  
	            sudo pvcreate $drive
		    d=$(echo "$?")
		    if [ "$d" = "0" ]
	            then
		        break
		    fi
	          done	  
	      ;;
	    5) 
	      ;;  
          *) break
		   
	      ;;
        esac
done
