require 'open-uri'
require 'nokogiri'
#l = open('http://stats.cbc.ca/nhl/teamstats.asp?teamno=21&type=schedule')

doc = Nokogiri::HTML(open('espn.html'))
doc.css('table.tablehead tr').each do |tr|
	puts tr['class']
end
# http://nokogiri.org/Nokogiri/XML/Node.html
#- find next game (first blank result)
#- if within time range, open the sports radio site
