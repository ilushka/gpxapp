require 'nokogiri'
require 'sinatra'

get '/' do
  erb :app
end

post '/' do
  f = File.open(params['gpxfile'][:tempfile])
  doc = Nokogiri::XML(f)
  f.close
  lat = doc.xpath('//xmlns:trkseg//@lat').map {|pt| pt.value}
  lon = doc.xpath('//xmlns:trkseg//@lon').map {|pt| pt.value}
  coors = lat.zip(lon)
  puts "var path = ["
  coors.each do |c|
    puts "  new google.maps.LatLng(#{c[0]}, #{c[1]})#{',' if c != coors.last}"
  end
  puts "];";
end

#f = File.open(ARGV[0])
#doc = Nokogiri::XML(f)
#f.close
#lat = doc.xpath('//xmlns:trkseg//@lat').map {|pt| pt.value}
#lon = doc.xpath('//xmlns:trkseg//@lon').map {|pt| pt.value}
#coors = lat.zip(lon)
#puts "var path = ["
#coors.each do |c|
  #puts "  new google.maps.LatLng(#{c[0]}, #{c[1]})#{',' if c != coors.last}"
#end
#puts "];";
