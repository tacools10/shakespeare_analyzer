require 'nokogiri'
require 'open-uri'

class ShakespeareAnalyzer

  def initialize(attributes = {})
    @url = attributes[:url]
    @totals = Hash.new
    @speakers = Array.new
    @xml_doc ||= attributes[:xml_doc]
  end

  attr_reader :url, :totals, :speakers
  attr_accessor :xml_doc

  # get all unique speakers from the given xml file

  def set_xml(url)
    @xml_doc = Nokogiri::XML(open(url))
  end

  def get_speakers(xml_doc)
     xml_doc.xpath("//SPEECH/SPEAKER").each do |speaker|
       if @speakers.length == 0 || !@speakers.include?("#{speaker.text}")
          @speakers << speaker.text
       end
     end
     return @speakers
  end

  # for each speaker, get the xml line nodes by matching on the speaker name and then count, excluding "ALL"
  # return a sorted array of the totals after sorting the hash and reversing it to create descending order

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

