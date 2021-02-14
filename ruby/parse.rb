require 'json'
require 've'
require_relative 'get_file_name'

# includes certain particles, ending copula です, and punctuation 。、！？
HELPERS = ["は", "が", "に", "へ", "の", "です", "。", "、", "！", "？"]

def get_cards(word, reading, line)
  if reading
    filename = get_file_name(reading[0])
    filename = "../card_templates/" + filename
    # puts word
    # puts file_name
    dictionary = File.read(filename)
    json_dictionary = JSON.parse(dictionary)
    word_info =  json_dictionary[word]
    cards = [] # there may be multiple meanings for one word/reading and we currently have no way of telling which one to choose

    if word_info
      word_info.each do |possibility|
        # puts word, possibility

        readings = possibility["readings"]
        kanji = possibility["kanji"]
        pos = possibility["pos"]


        definitions = possibility["definitions"]
        misc = possibility["misc"]
        fields = possibility["fields"]
        references = possibility["references"]
        # puts readings, pos, definitions, misc, fields, references
        
        # card = word + "<br>Example sentence: " + line + "; Readings: " + readings*", " + "<br>Parts of Speech: " + pos*", " + "<br>"

        card = word + "<br>Example sentence: " + line
        if readings
          card = card + "; Readings: " + readings*", "
        else
          card = card + "; Kanji: " + kanji*", "
        end
        card = card + "<br>Parts of Speech: " + pos*", " + "<br>"
        definitions.each_with_index do |definition, number|
          card = card + "#{number+1}. #{definition}<br>"
        end
        card = card + "misc: " + misc*", " + "<br> fields: " + fields*", " + "<br> see also: " + references*", "
        cards << card
      end
      return cards
    else
      return []
    end
  end
  return []
end


def analyze_line(line, output_file)
  words = Ve.in(:ja).words(line)
  # puts words.collect(&:tokens)
  words.each do |word_data|
    reading =  word_data.tokens[0][:reading]
    puts word_data
    word = word_data.tokens[0][:lemma] # may be kanji or kana
    cards = get_cards(word, reading, line)
    # File.open(output_file, "a") do |file|
    #   cards.each do |card|
    #     file.puts card
    #   end
    # end
  end
end


def main
  raise ArgumentError, "Please provide only one file" unless ARGV.length == 1
  input_file = ARGV[0]
  raise StandardError.new, "This file does not exist" unless File.exist?(input_file)
  File.readlines(input_file).each do |line|
    analyze_line(line.chomp, 'cards.txt')
  end
  puts "done!"
end
  

main
