DATE=`date +%Y-%m-%d`
DIR_FILES='/home/matt/leafs/'
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d $DIR_FILES -l 12600 -isAT -k 0 -a $DATE.aac
ffmpeg -v 5 -y -i "${DIR_FILES}/${DATE}.aac.mp3" -acodec libmp3lame -ac 2 -ab 192k "${DIR_FILES}/${DATE}.mp3";
ln -s $DIR_FILES/$DATE.mp3 /home/matt/Dropbox/leafs/
#TODO: add ID tag information about who they are playing
