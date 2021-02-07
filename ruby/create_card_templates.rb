require 'nokogiri'
require 'json'


POS_INDEX = 0
DEF_INDEX = 1
MISC_INDEX = 2


def get_file_name(character)
  case character
  when "あ", "ア"
    return "あ.json"
  when "い", "イ"
    return "い.json"
  when "う", "ウ"
    return "う.json"
  when "え", "エ"
    return "え.json"
  when "お", "オ"
    return "お.json"
  when "か", "カ"
    return "か.json"
  when "が", "ガ"
    return "が.json"
  when "き", "キ"
    return "き.json"
  when "ぎ", "ギ"
    return "ぎ.json"
  when "く", "ク"
    return "く.json"
  when "ぐ", "グ"
    return "ぐ.json"
  when "け", "ケ"
    return "け.json"
  when "げ", "ゲ"
    return "げ.json"
  when "こ", "コ"
    return "こ.json"
  when "ご", "ゴ"
    return "ご.json"
  when "さ", "サ"
    return "さ.json"
  when "ざ", "ザ"
    return "ざ.json"
  when "し", "シ"
    return "し.json"
  when "じ", "ジ"
    return "じ.json"
  when "す", "ス"
    return "す.json"
  when "ず", "ズ"
    return "ず.json"
  when "せ", "セ"
    return "せ.json"
  when "ぜ", "ゼ"
    return "ぜ.json"
  when "そ", "ソ"
    return "そ.json"
  when "ぞ", "ゾ"
    return "ぞ.json"
  when "た", "タ"
    return "た.json"
  when "だ", "ダ"
    return "だ.json"
  when "ち", "チ"
    return "ち.json"
  when "ぢ", "ヂ"
    return "ぢ.json"
  when "つ", "ツ"
    return "つ.json"
  when "づ", "ヅ"
    return "づ.json"
  when "て", "テ"
    return "て.json"
  when "で", "デ"
    return "で.json"
  when "と", "ト"
    return "と.json"
  when "ど", "ド"
    return "ど.json"
  when "な", "ナ"
    return "な.json"
  when "に", "ニ"
    return "に.json"
  when "ぬ", "ヌ"
    return "ぬ.json"
  when "ね", "ネ"
    return "ね.json"
  when "の", "ノ"
    return "の.json"
  when "は", "ハ"
    return "は.json"
  when "ば", "バ"
    return "ば.json"
  when "ぱ", "パ"
    return "ぱ.json"
  when "ひ", "ヒ"
    return "ひ.json"
  when "び", "ビ"
    return "び.json"
  when "ぴ", "ピ"
    return "ぴ.json"
  when "ふ", "フ"
    return "ふ.json"
  when "ぶ", "ブ"
    return "ぶ.json"
  when "ぷ", "プ"
    return "ぷ.json"
  when "へ", "ヘ"
    return "へ.json"
  when "べ", "ベ"
    return "べ.json"
  when "ぺ", "ペ"
    return "ぺ.json"
  when "ほ", "ホ"
    return "ほ.json"
  when "ぼ", "ボ"
    return "ぼ.json"
  when "ぽ", "ポ"
    return "ぽ.json"
  when "ま", "マ"
    return "ま.json"
  when "み", "ミ"
    return "み.json"
  when "む", "ム"
    return "む.json"
  when "め", "メ"
    return "め.json"
  when "も", "モ"
    return "も.json"
  when "や", "ヤ"
    return "や.json"
  when "ゆ", "ユ"
    return "ゆ.json"
  when "よ", "ヨ"
    return "よ.json"
  when "ら", "ラ"
    return "ら.json"
  when "り", "リ"
    return "り.json"
  when "る", "ル"
    return "る.json"
  when "れ", "レ"
    return "れ.json"
  when "ろ", "ロ"
    return "ろ.json"
  when "わ", "ワ"
    return "わ.json"
  when "ゐ", "ヰ"
    return "ゐ.json"
  when "ゑ", "ヱ"
    return "ゑ.json"
  when "を", "ヲ"
    return "を.json"
  when "ん", "ン"
    return "ん.json"
  else
    return "other.json"
  end
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
