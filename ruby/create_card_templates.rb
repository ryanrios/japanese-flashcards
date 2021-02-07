require 'nokogiri'
require 'json'


POS_INDEX = 0
DEF_INDEX = 1
MISC_INDEX = 2


def to_hiragana(character)

end

def get_kanji(entry)
    # check if an entry has associated kanji
    kanji = []
    if !entry.xpath('k_ele/keb').empty?
        entry.xpath('k_ele/keb').each{|node| kanji.push(node.content)}
    end
    return kanji
end


def get_readings(entry)
    # every word will have an associated reading
    readings = []
    entry.xpath('r_ele/reb').each{|node| readings.push(node.content)}
    return readings
end


def get_senses(entry)
    #every word will have associated senses
    senses = []
    entry.xpath('sense').each do |sense|
        parts_of_speech = []
        definitions = []
        misc_information = []
        sense_info = [parts_of_speech, definitions, misc_information]
        sense.xpath('pos').each do |pos|
            sense_info[parts_of_speech].push(pos.content)
        end
        sense.xpath('gloss').each do |gloss|
            sense_info[definitions].push(gloss.content)
        end
        sense.xpath('misc').each do |misc|
            sense_info[misc_information].push(misc.content)
        end
        senses.push(sense_info)
    end
    return senses
end


def get_filenames(readings)
    # get all the filenames this word will be saved under
    # sorted by first kana character in reading (normalized to hiragana)
    # ie if a word can start with い, イ, ゆ, or ユ then we know to save it under
    # い.json and ゆ.json
    readings.each do |reading|
        first_kana = reading[0]
        first_kana = to_hiragana(first_kana)
    end
end


def word_to_json(kanji, readings, senses)
    # saves word data in a json file (sorted by initial hiragana) 

    # get the unique first characters of possible readings so we know
    # which file to save it under
    possibl

end

def analyze_entries(entries)
    # get all words and all their associated kanji, readings, and senses
    entries.each do |entry|
        # k_ele = kanji element of an entry
        # keb = the actual kanji itself

        # r_ele = the kana element of an entry
        # reb = the actual kana element itself

        # sense = part of speech, misc information, and glosses (defintion)

        kanji = get_kanji(entry)
        readings = get_readings(entry)
        senses = get_senses(entry)

        word_to_json(kanji, readings, senses)
    end
end


def main
    # load the JMdict_e dictionary XML
    dictionary_doc = File.open("../../JMdict_e/JMdict_e" ) {|f| Nokogiri::XML(f)}
    entries = dictionary_doc.xpath("//entry")
    analyze_entries(entries)
end

main

entries.each do |entry|



    if !word_kanji.empty?
        word_kanji.each do |kanji|
            field_one = kanji
            field_two = word_readings*", "
            senses.each do |sense|
                pos_string = "pos: " + sense[0]*", "
                definitions_string = ""
                sense[1].each_with_index do |definition, definition_number|
                    definitions_string += "#{definition_number+1}" + ". " + definition
                    if definition_number+1 != sense[1].length
                        definitions_string += "<br>"
                    end
                end
                if sense[2].length >= 1
                    misc_string = "misc info: " + sense[2]*", "
                else
                    misc_string = "misc info: none"
                end
                field_three = pos_string + "<br>" + definitions_string + "<br>" + misc_string
                field_four = "Example sentence: <sentence>"
                card_string = field_one + "<br>" + field_four + "; " + field_two + "<br>" + field_three
                puts card_string, "\n"
            end
        end
    end


end
