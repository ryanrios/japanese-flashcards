require 'nokogiri'
require 'json'

require_relative 'get_file_name'


POS_INDEX = 0
DEF_INDEX = 1
MISC_INDEX = 2



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

        sense.xpath('pos').each do |pos|
            parts_of_speech.push(pos.content)
        end
        sense.xpath('gloss').each do |gloss|
            definitions.push(gloss.content)
        end
        sense.xpath('misc').each do |misc|
            misc_information.push(misc.content)
        end

        #misc_information is the only one that could possibly be empty
        if misc_information.empty?
            misc_information = ['none']
        end

        sense_info = [parts_of_speech, definitions, misc_information]
        senses.push(sense_info)
    end
    return senses
end


def get_filenames(readings)
    # get all the filenames this word will be saved under
    # sorted by first kana character in reading (normalized to hiragana)
    # ie if a word can start with い, イ, ゆ, or ユ then we know to save it under
    # い.json and ゆ.json

    # get the first characters of possible readings so we know
    # which file(s) to save the word under
    filenames = []
    readings.each do |reading|
        filename = get_file_name(reading[0])
        if !(filenames.include?(filename))
            filenames.push(filename)
        end
    end
    return filenames
end


def entry_to_file(kanji, readings, senses)
    # saves entry info in relevant files


    # start by saving kanji (if those exist) with associated info
    if !kanji.empty?
        kanji.each do |listing|
            # get the needed filenames
            filenames = get_filenames(readings)
            filenames.each do |filename|
                filename = "../card_templates/" + filename
                target_json = File.read(filename)
                target_json_dictionary = JSON.parse(target_json)
                senses.each do |sense|
                    if target_json_dictionary.key?(listing)
                        tar get_json_dictionary[listing].append({:readings => readings, :pos => sense[POS_INDEX], :definitions => sense[DEF_INDEX], :misc => sense[MISC_INDEX]})
                    else
                        target_json_dictionary[listing] = [{:readings => readings, :pos => sense[POS_INDEX], :definitions => sense[DEF_INDEX], :misc => sense[MISC_INDEX]}]
                    end
                end
                File.open(filename, "w") {|f| f.write(JSON.generate(target_json_dictionary))}
            end
        end
    end

    # do the same but with readings as keys
    readings.each do |reading|
        # get the needed filenames
        filenames = get_filenames(reading)
        filenames.each do |filename|
            filename = "../card_templates/" + filename
            target_json = File.read(filename)
            target_json_dictionary = JSON.parse(target_json)
            senses.each do |sense|
                if target_json_dictionary.key?(reading)
                    if kanji.empty?
                        target_json_dictionary[reading].append({:readings => readings, :pos => sense[POS_INDEX], :definitions => sense[DEF_INDEX], :misc => sense[MISC_INDEX]})
                    else
                        target_json_dictionary[reading].append({:kanji => kanji, :pos => sense[POS_INDEX], :definitions => sense[DEF_INDEX], :misc => sense[MISC_INDEX]})
                    end
                else
                    if kanji.empty?
                        target_json_dictionary[reading] = [{"readings" => readings, "pos" => sense[POS_INDEX], "definitions" => sense[DEF_INDEX], "misc" => sense[MISC_INDEX]}]
                    else
                        target_json_dictionary[reading] = [{"kanji" => kanji, "pos" => sense[POS_INDEX], "definitions" => sense[DEF_INDEX], "misc" => sense[MISC_INDEX]}]
                    end
                end
            end
            File.open(filename, "w") {|f| f.write(JSON.generate(target_json_dictionary))}
        end
    end
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

        entry_to_file(kanji, readings, senses)
    end
end


def main
    # load the JMdict_e dictionary XML
    dictionary_doc = File.open("../../JMdict_e/JMdict_e" ) {|f| Nokogiri::XML(f)}
    entries = dictionary_doc.xpath("//entry")
    analyze_entries(entries)
    puts "done!"
end

main
