require 'nokogiri'
require 'open-uri'

class ShakespeareAnalyzer

  def initialize(attributes = {})
    @url = attributes[:url]
    @xml_doc ||= attributes[:xml_doc]
  end

  attr_reader :url
  attr_accessor :xml_doc

  # get all unique speakers from the given xml file

  def set_xml(url)
    if url == nil
        return
    end
      @xml_doc = Nokogiri::XML(open(url))
  end

  def get_speakers()
     nodes = @xml_doc.xpath("//SPEECH/SPEAKER")
     speakers = Array.new
     nodes.to_a.uniq.each { |node| speakers << node.text }
     return speakers
  end

  # for each speaker, get the xml line nodes by matching on the speaker name and then count, excluding "ALL"
  # return a sorted array of the totals after sorting the hash and reversing it to create descending order

  def parse_count_sort(speakers)
    totals = Hash.new
    speakers.each do |character|
      nodes = @xml_doc.xpath("//SPEECH[SPEAKER[text() = '#{character}']]/LINE")
      count = nodes.length
      if character != "ALL"
        totals["#{character}"] = count
      end
    end

    return totals.sort_by { |char, count| count}.reverse
  end

end

