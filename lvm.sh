while true
do
	echo "(1) display Physicals Volumes(PV)"
        echo "(2) display Volume Groups(VG)"
	echo "(3) display Logical Volume(LVM)"
	echo "(4) create Physicals Volumes(PV)"
	echo "(5) create Virtual Groups(VG)"
        echo "(6) create Logical Volume(LVM)"
	echo "(*) Exits"
	read -p "Choose: " choose

	case $choose in
           1) sudo pvdisplay
	      ;;
	   2) sudo vgdisplay
	      ;;
	   3) sudo lvdisplay
              ;;
           4) a=$(lsblk --noheading -r -o NAME,TYPE,MOUNTPOINT | awk '$1~/[[:alnum:]]/ && $2 == "disk" && $3 == ""' | sed 's/disk//') 
              b=$(sudo pvdisplay | grep -o "/dev.*" | sed 's/dev//' | tr -d /)
	      echo $a
	      echo $b
	      c=" "
	  
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
	  5) echo "Avalable PV" 
             sudo pvdisplay | grep -B 3 "Allocatable           NO" | grep "/dev/.*"
	     read -p "Select physical volume: " vg
	     read -p "Volume Group  Name: " vgname
	     sudo vgcreate $vgname $vg
	          
	      ;;  
	  6) echo "Choose available VG"
	     read -p "Logical volume Name: " lvname
             sudo vgdisplay | grep -B 10 "Cur LV                0"| grep "VG Name" | sed 's/VG Name               //'
             read -p "Select Volume Group: " vg1
	     echo "Example: size 10G"
	     read -p "size : " size
	     sudo lvcreate --size $size --name $lvname $vg1
             ;;

          *) break
		   
	      ;;
        esac
done
