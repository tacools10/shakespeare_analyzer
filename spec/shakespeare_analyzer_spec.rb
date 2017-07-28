require "spec_helper"
require 'shakespeare_analyzer'
require 'nokogiri'

RSpec.describe ShakespeareAnalyzer do
  context ".get_speakers"
    it "takes all unique elements for a given node" do
      test_analyzer = ShakespeareAnalyzer.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.SPEECH {
            xml.SPEAKER "MACBETH"
            xml.LINE "test line 1"
            xml.LINE "test line 2"
          }
          xml.SPEECH {
            xml.SPEAKER "DUNCAN"
            xml.LINE "test line 3"
            xml.LINE "test line 4"
          }
        }
      end
      test_xml = builder.to_xml
      puts test_xml
      test_analyzer.xml_doc = test_xml
      puts test_analyzer.get_speakers(test_analyzer.xml_doc)
      # expect(test_analyzer.get_speakers(test_analyzer.xml)).to eq ["MACBETH", "DUNCAN"]
    end
end

