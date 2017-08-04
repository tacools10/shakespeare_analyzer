require 'nokogiri'
require 'open-uri'

doc = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))

sets = doc.search("SPEAKER")

p sets

array = []
sets.each do |set|
  p set.inner_text
  array << set.inner_text unless set.inner_text == "ALL"
end

counts = Hash.new(0)
array.each { |name| counts[name] += 1 }

p counts
