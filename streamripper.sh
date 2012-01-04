DATE=`date +%Y-%m-%d`
DIR_FILES='/home/matt/leafs/'
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d $DIR_FILES -l 10800 -isAT -k 0 -a $DATE.aac
ffmpeg -v 5 -y -i "${DIR_FILES}/${DATE}.aac.mp3" -acodec libmp3lame -ac 2 -ab 192k "${DIR_FILES}/${DATE}.mp3";
#TODO: add ID tag information about who they are playing
#mv $DIR_FILES/$DATE.mp3 ~/Dropbox/leafs/
