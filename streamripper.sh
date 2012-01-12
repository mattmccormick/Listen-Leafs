DATE=`date -d +%Y-%m-%d`
DIR_FILES='/home/matt/leafs/'
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d $DIR_FILES -l 10800 -isAT -k 0 -a $DATE.aac
ffmpeg -v 5 -y -i "${DIR_FILES}/${DATE}.aac.mp3" -acodec libmp3lame -ac 2 -ab 160k -aq 2 -metadata title="Toronto $1 - ${DATE}" -metadata author="AM 640 Toronto" "${DIR_FILES}/${DATE}.mp3"; 
ln -s $DIR_FILES/$DATE.mp3 /home/matt/www/mattmccormick.ca/public/leafs/ #/home/matt/Dropbox/leafs/ 
DIR_SCRIPT="$( cd "$( dirname "$0" )" && pwd )" 
ruby "${DIR_SCRIPT}/feed.rb"
#jets_streaming_url = 'http://208.80.54.96/CFRWAMAAC'
