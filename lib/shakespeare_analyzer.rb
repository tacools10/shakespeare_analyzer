require 'nokogiri'
require 'open-uri'

class ShakespeareAnalyzer
  # Your code goes here...

  def initialize(url)
    @url = url
    @totals = Hash.new
    @speakers = Array.new
  end

  attr_reader :url, :totals, :speakers

  def get_speakers
     xml_doc = Nokogiri::XML(open(url))
     xml_doc.xpath("//SPEECH/SPEAKER").each do |speaker|
       if @speakers.length == 0 || !@speakers.include?("#{speaker.text}")
          @speakers << speaker.text
       end
     end
     return @speakers
  end

  def parse_count_sort(speakers)
    xml_doc = Nokogiri::XML(open(url))
    speakers.each do |character|
      count = 0
      xml_doc.xpath("//SPEECH[SPEAKER[text() = '#{character}']]/LINE").each do |line|
          count += 1
      end
      @totals["#{character.upcase}"] = count
    end

    return @totals.sort_by { |char, count| count}.reverse
  end

end

example = ShakespeareAnalyzer.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

values = example.parse_count_sort(example.get_speakers)


# //SPEECH[SPEAKER[text() = '#{character.upcase}']]/LINE
