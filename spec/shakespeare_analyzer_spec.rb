require "spec_helper"
require 'shakespeare_analyzer'
require 'nokogiri'

# create a test xml using Nokogiri and run both instance methods to test results"
# this was my first time writing tests in ruby but with more time I would have used :let or :before to
# get rid of the repetitive code setting up the test xml both times.

RSpec.describe ShakespeareAnalyzer do
  context ".get_speakers"
    it "takes all unique elements for a given node" do
      test_analyzer = ShakespeareAnalyzer.new()
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
      test_xml = Nokogiri::XML(builder.to_xml)
      expect(test_analyzer.get_speakers(test_xml)).to eq ["MACBETH", "DUNCAN"]
    end

  context ".parse_count_sort"
    it "returns a sorted hash of lines for each character" do
      test_analyzer = ShakespeareAnalyzer.new()
      speakers = ["MACBETH", "DUNCAN"]
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
      test_xml = Nokogiri::XML(builder.to_xml)
      expect(test_analyzer.parse_count_sort(speakers, test_xml)).to eq [["DUNCAN", 2], ["MACBETH", 2]]
    end
end

