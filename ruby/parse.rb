require 've'

# includes certain particles, ending copula です, and punctuation 。、！？
HELPERS = ["は", "が", "に", "へ", "の", "です", "。", "、", "！", "？"]


def main
  input_file = ARGV
  raise ArgumentError, "Please provide only one file" unless input_file.length == 1
  
