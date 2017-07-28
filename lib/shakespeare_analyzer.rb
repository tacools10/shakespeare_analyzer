require 'nokogiri'
require 'open-uri'

class ShakespeareAnalyzer

  def initialize(url)
    @url = url
    @totals = Hash.new
    @speakers = Array.new
    @xml_doc = Nokogiri::XML(open(url))
  end

  attr_reader :url, :totals, :speakers
  attr_accessor :xml_doc

  def get_speakers(xml_doc)
     xml_doc.xpath("//SPEECH/SPEAKER").each do |speaker|
       if @speakers.length == 0 || !@speakers.include?("#{speaker.text}")
          @speakers << speaker.text
       end
     end
     return @speakers
  end

  def parse_count_sort(speakers, xml_doc)
    speakers.each do |character|
      count = 0
      xml_doc.xpath("//SPEECH[SPEAKER[text() = '#{character}']]/LINE").each do |line|
          count += 1
      end
      if character != "ALL"
        @totals["#{character.upcase}"] = count
      end
    end

    return @totals.sort_by { |char, count| count}.reverse
  end

end

example = ShakespeareAnalyzer.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

values = example.parse_count_sort(example.get_speakers(example.xml_doc), example.xml_doc)

