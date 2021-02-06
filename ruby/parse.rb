require 've'
require 'rexml/document'

include REXML

#find a way to rewrite programs so that Dictionary doc is only opened once and can be perptually open essentially (open in separate program that never
#closes, find way to feed data to that program?)

# Better idea(???!!): go through evert word in dictionary, make card templates as strings.
# Keep some mapping of templates to files and just fetch templates instead 

# JMdict for defintion lookup
# DICTIONARY_XML = File.new("../../JMdict_e/JMdict_e")
# puts "done!"
# DICTIONARY_DOC = Document.new(DICTIONARY_XML)
# puts "done2!"

puts DICTIONARY_DOC.root

# includes certain particles, ending copula です, and punctuation 。、！？
HELPERS = ["は", "が", "に", "へ", "の", "です", "。", "、", "！", "？"]

def analyze_line(line, output_file)
  words = Ve.in(:ja).words(line)
  puts words.collect(&:lemma)
end


def main
  raise ArgumentError, "Please provide only one file" unless ARGV.length == 1
  input_file = ARGV[0]
  output_file = File.new("cards.txt", "w")
  raise StandardError.new, "This file does not exist" unless File.exist?(input_file)
  File.readlines(input_file).each do |line|
    # analyze_line(line.chomp, output_file)
  end
end
  

main
