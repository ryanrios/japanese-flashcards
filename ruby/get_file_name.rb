def get_file_name(character)
    # we still check hiragana because we don't have a method of easily 
    # distinguishing hiragana from katakana
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