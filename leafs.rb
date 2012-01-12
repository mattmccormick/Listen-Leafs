require 'open-uri'
require 'nokogiri'
require 'tzinfo'

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

		opponent = td[1].text()

		if opponent[0] == '@'
			full_opp = 'at ' + opponent[1..-1]
		else
			full_opp = 'vs ' + opponent[2..-1]
		end

		if diff.abs < 60	# if at starting time
			puts "Running streamripper\n"
			system("/bin/sh #{file_dir}/streamripper.sh '#{full_opp}'&")
		end
		exit
	end
end
