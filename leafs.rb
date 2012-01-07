require 'open-uri'
require 'nokogiri'
require 'tzinfo'

#jets_streaming_url = 'http://208.80.54.96/CFRWAMAAC'
streaming_url = 'http://6703.live.streamtheworld.com/CFMJAMAAC'
file_dir = File.dirname(File.expand_path(__FILE__))

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
			#system("streamripper #{streaming_url} -d #{output_dir} -i &")	# for saving
			puts "Running streamripper\n"
			system("/bin/sh #{file_dir}/streamripper.sh &")
		end
		exit
	end
end
