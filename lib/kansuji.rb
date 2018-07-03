module Kanji
  class << self; attr_reader :first, :last end
  @first = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
  @last = { 1 => '十', 2 => '百', 3 => '千', 4 => '万', 8 => '億', 12 => '兆', 16 => '京', 20 => '垓', 24 => '𥝱', 28 => '穣', 32 => '溝',
            36 => '澗', 40 => '正', 44 => '載', 48 => '極', 52 => '恒河沙', 56 => '阿僧祇', 60 => '那由他', 64 => '不可思議', 68 => '無量大数' }
end
# Convert number to Kanji
class Integer
  include Kanji
  def convert(str)
    return Kanji.first[str.to_i] if str.length == 1
    return convert(str[1, str.length - 1]) if str[0] == '0'
    if Kanji.last.key?(str.length - 1)
      return (str[0] == '1' && str.length < 5 ? '' : Kanji.first[str[0].to_i])\
               + Kanji.last[str.length - 1] + convert(str[1, str.length - 1])
    end
    Kanji.last.keys.reverse_each do |key|
      if key <= str.length - 1
        return convert(str[0, str.length - key]) + Kanji.last[key] \
         + convert(str[str.length - key, key])
      end
    end
  end

  def to_kansuji
    zero? ? '零' : convert(to_s)
  end
end
# Convert kasuji to number
class String
  def value_of(str)
    return Kanji.first.index(str) if Kanji.first.include?(str)
    return (10**Kanji.last.key(str)) if Kanji.last.value?(str)
    max = ''
    Kanji.last.values.each { |value| max = value if str.include?(value) }
    muti = value_of(str[0, str.index(max)])
    (muti.equal?(0) ? 1 : muti) * (10**Kanji.last.key(max)) \
      + value_of(str[(str.index(max) + max.length)..-1])
  end

  def to_number
    self == '零' ? 0 : value_of(self)
  end
end
