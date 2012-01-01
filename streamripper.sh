DATE=`date +%Y-%m-%d`
DIR_FILES='/home/matt/leafs/'
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d $DIR_FILES -l 10800 -isAT -k 0 -a $DATE.mp3
mv $DIR_FILES/$DATE.mp3 ~/Dropbox/leafs/
