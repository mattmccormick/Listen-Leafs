DATE=`date +%Y-%m-%d`
streamripper http://6703.live.streamtheworld.com/CFMJAMAAC -d ~/rails/leafs/files/ -l 15 -isAT -k 0 -a $DATE.mp3
mv ~/rails/leafs/files/$DATE.mp3 ~/Ubuntu\ One/
