require_relative 'shakespeare_analyzer'

# create an instance of the class and store it.

example = ShakespeareAnalyzer.new({:url => "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"})

example.set_xml(example.url)

# store the results

values = example.parse_count_sort(example.get_speakers(example.xml_doc), example.xml_doc)

# iterate over the results to print the requested data in the required format

values.each do |value|
    puts "Character: #{value[0]} | Lines: #{value[1]}"
end
