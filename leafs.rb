require 'open-uri'
require 'nokogiri'
require 'tzinfo'

streaming_url = 'http://6703.live.streamtheworld.com/CFMJAMAAC'

doc = Nokogiri::HTML(open('http://espn.go.com/nhl/team/schedule/_/name/tor/toronto-maple-leafs'))
doc.css('table.tablehead tr').each do |tr|
	css_class = tr.attribute('class').to_str()
	next if css_class == 'stathead' || css_class == 'colhead'
	td = tr.children()

	time_result = td[2].to_str()

	if time_result.index('PM')	# find the first game that hasn't completed yet
		tz = TZInfo::Timezone.get('America/New_York')
		eastern_now = tz.now
		timezone = eastern_now.dst?() ? 'EDT' : 'EST'
		
		day = td[0].to_str().slice(5..-1)	# just get the date without the day of the week
		game_time = DateTime.parse(day + ' at ' + time_result + ' ' + timezone)
		diff = game_time.to_time - Time.now

		if diff < 60 * 10	# if within 10 minutes of game time
			#system("vlc #{streaming_url} &")	# for listening
			system("streamripper #{streaming_url} -d /home/matt/rails/leafs/files/ -i &")	# for saving
		end
		exit
	end
end
