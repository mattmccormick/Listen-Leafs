require 'rss/maker'
#require 'digest/md5'

DIR = '/home/matt/www/mattmccormick.ca/public/leafs'

content = RSS::Maker.make('2.0') do |feed|
	feed.channel.title = 'Toronto Maple Leafs radio broadcasts'
	feed.channel.link = 'http://mattmccormick.ca'
	feed.channel.description = 'Download radio broadcasts of Toronto Maple Leafs games'
	feed.items.do_sort = true

	files = `ls -t #{DIR}/*.mp3`.split("\n")
  files.each do |f|
		date = File.basename(f, '.mp3')
		item = feed.items.new_item
		item.title = "Toronto Maple Leafs game #{date}"
		item.link = 'http://www.640toronto.com'
		item.date = File.ctime(f)
		#item.guid.content = Digest::MD5.hexdigest(File.read(f))
		#item.guid.isPermaLink = false
		item.enclosure.url = "http://mattmccormick.ca/leafs/#{date}.mp3"
		item.enclosure.length = File.size(f)
		item.enclosure.type = 'audio/mpeg'
	end
end

File.open("#{DIR}/feed.xml", 'w') do |f|
	f.write(content)
end
