require 've'


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
