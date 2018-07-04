module Kanji
  class << self; attr_reader :first, :last end
  @first = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
  @last = { 1 => '十', 2 => '百', 3 => '千', 4 => '万', 8 => '億', 12 => '兆',
            16 => '京', 20 => '垓', 24 => '𥝱', 28 => '穣', 32 => '溝', 36 => '澗',
            40 => '正', 44 => '載', 48 => '極', 52 => '恒河沙', 56 => '阿僧祇',
            60 => '那由他', 64 => '不可思議', 68 => '無量大数' }
end
# Convert number to Kanjic
class Integer
  def to_kansuji(str = to_s)
    return zero? ? '零' : Kanji.first[str.to_i] if str.length == 1
    return to_kansuji(str[1, str.length - 1]) if str[0] == '0'
    Kanji.last.keys.reverse_each do |k|
      next unless k <= (len = str.length) - 1
      temp = (str[0] == '1' && len < 5 ? '' : Kanji.first[str[0].to_i])
      return (k == len - 1 ? temp : to_kansuji(str[0, len - k])) \
       + Kanji.last[k] + to_kansuji(str[len - k, k])
    end
  end
end
# Convert kasuji to number
class String
  def to_number(str = to_s)
    return 0 if str == '零'
    return Kanji.first.index(str) if Kanji.first.include?(str)
    return (10**Kanji.last.key(str)) if Kanji.last.value?(str)
    max = ''
    Kanji.last.values.each { |value| max = value if str.include?(value) }
    ((muti = to_number(str[0, str.index(max)])).equal?(0) ? 1 : muti) * \
      10**Kanji.last.key(max) + to_number(str[(str.index(max) + max.length)..-1])
  end
end
