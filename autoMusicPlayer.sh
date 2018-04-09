#! /bin/bash
# keep_checking () function is to check whether a usb is inserted or not!!
# If it finds a usb inserted to the board then it executes the function
# start_playing () to play the musics.
keep_checking ()
{
	LSCMD=1
	while [ $LSCMD -ne 0 ]; do
		sleep 2
		echo "Pen drive is not in….."
		mount | tail -n 1 |grep "/dev/sd" >> /dev/null 2>&1
		LSCMD=$?
	done
	start_playing
}


# once the usb is found start_playing() function starts executing and the 
#mp3 files in the usb will start to play. If any error finding the usb it goes 
#back to the function keep_checking() to again check whether the usb is 
#inserted or not.
start_playing ()
{
	FOLDER=$(mount | tail -n 1|cut -d' ' -f3)
	cd $FOLDER
	for FILE in *.mp3; do
		mpg123 --resync-limit 200 "$FILE"
	done
	keep_checking
}
# if usb inserted and then removed again start_playing() function stops 
#its execution and does have to check for the usb having mp3 files to be 
#checked again. So the keep_checking() function is called again.
keep_checking 