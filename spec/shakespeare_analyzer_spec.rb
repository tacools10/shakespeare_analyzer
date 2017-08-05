require "spec_helper"
require 'shakespeare_analyzer'
require 'nokogiri'

# create a test xml using Nokogiri and run both instance methods to test results"
# this was my first time writing tests in ruby but with more time I would have used :let or :before to
# get rid of the repetitive code setting up the test xml both times.

RSpec.describe ShakespeareAnalyzer do

  let(:builder) {Nokogiri::XML::Builder.new do |xml|
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
        } end }
  let(:test_analyzer) {ShakespeareAnalyzer.new({:xml_doc => Nokogiri::XML(builder.to_xml)})}

  context ".get_speakers"
    it "takes all unique elements for a given node" do
      expect(test_analyzer.get_speakers()).to eq ["MACBETH", "DUNCAN"]
    end

  context ".set_xml"
    it "should correctly set the xml of the document" do
      expect(test_analyzer.set_xml(test_analyzer.url)).to eq nil
    end

  context ".parse_count_sort"
    it "returns a sorted hash of lines for each character" do
      expect(test_analyzer.parse_count_sort(test_analyzer.get_speakers())).to eq [["DUNCAN", 2], ["MACBETH", 2]]
    end
end

