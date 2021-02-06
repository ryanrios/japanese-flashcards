require 'nokogiri'

dictionary_doc = File.open("../../JMdict_e/JMdict_e" ) {|f| Nokogiri::XML(f)}
entries = dictionary_doc.xpath("//entry")

entries.each do |entry|

    # k_ele = kanji element of an entry
    # keb = the actual kanji itself

    # r_ele = the kana element of an entry
    # reb = the actual kana element itself

    # sense = part of speech, misc information, and glosses (defintion)

    word_kanji = []
    word_readings = []
    parts_of_speech = []
    definitions = []

    

    # check if an entry has associated kanji
    if !entry.xpath('k_ele/keb').empty?
        entry.xpath('k_ele/keb').each{|node| word_kanji.push(node.content)}
    end
    
    # every word will have an associated reading
    entry.xpath('r_ele/reb').each{|node| word_readings.push(node.content)}

    #every word will have associated senses
    entry.xpath('sense').each do |sense|
        sense.xpath('pos').each{|pos| if !(parts_of_speech.include?(pos.content)) then parts_of_speech.push(pos.content) end}
        sense.xpath('gloss').each{|definition| if !(definitions.include?(definition.content)) then definitions.push(definition.content) end}
    end


    puts "KANJI: ", word_kanji
    puts "READINGS: ", word_readings
    puts "PARTS OF SPEECH: ", parts_of_speech
    puts "DEFINITIONS: ", definitions
    

    puts "\n"

end
