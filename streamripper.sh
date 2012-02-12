DATE=`date -d '-6 hours' +%Y-%m-%d` # because server is on UTC time
DIR_FILES='/home/matt/leafs/'
MP3_FILE=${DIR_FILES}${DATE}.mp3
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d $DIR_FILES -l 10500 -isAT -k 0 -a $DATE.aac
ffmpeg -v 5 -y -i "${DIR_FILES}/${DATE}.aac.mp3" -acodec libmp3lame -ac 2 -ab 96k "${MP3_FILE}"
id3v2 -t "Toronto $1 - ${DATE}" -a "AM 640 Toronto" "${MP3_FILE}"
ln -s $MP3_FILE /home/matt/www/mattmccormick.ca/public/leafs/ 
DIR_SCRIPT="$( cd "$( dirname "$0" )" && pwd )" 
ruby "${DIR_SCRIPT}/feed.rb"
#jets_streaming_url = 'http://208.80.54.96/CFRWAMAAC'
