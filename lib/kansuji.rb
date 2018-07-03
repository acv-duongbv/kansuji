# frozen_string_literal: true
# to include for numeric and string
module Kansuji
  class << self; attr_reader :first, :last end
  @first = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
  @last = { 0 => '', 1 => '十', 2 => '百', 3 => '千', 4 => '万', 8 => '億',
            12 => '兆', 16 => '京', 20 => '垓', 24 => '𥝱', 28 => '穣', 32 => '溝',
            36 => '澗', 40 => '正', 44 => '載', 48 => '極', 52 => '恒河沙',
            56 => '恒河沙', 60 => '那由他', 64 => '不可思議', 68 => '無量大数' }
end
# Convert number to kansuji
class Numeric
  include Kansuji
  def convert(str)
    return Kansuji.first[str.to_i] if str.length == 1
    return convert(str[1, str.length - 1]) if str[0] == '0'
    if Kansuji.last.key?(str.length - 1)
      return (str[0] != '1' ? Kansuji.first[str[0].to_i] : '') \
               + Kansuji.last[str.length - 1] + convert(str[1, str.length - 1])
    end
    Kansuji.last.keys.reverse_each do |key|
      if key <= str.length - 1
        return convert(str[0, str.length - key]) \
                 + Kansuji.last[key] + convert(str[str.length - key, key])
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
    return 0 if str == '' || str.nil?
    return Kansuji.first.index(str) if Kansuji.first.include?(str)
    return (10**Kansuji.last.key(str)) if Kansuji.last.value?(str)
    Kansuji.last.values.reverse.map do |value|
      next unless str.include?(value)
      muti = value_of(str[0, str.index(value)])
      return (muti.equal?(0) ? 1 : muti) * (10**Kansuji.last.key(value)) \
        + value_of(str[str.index(value) + 1, str.length - str.index(value)])
    end
  end

  def to_number
    self == '零' ? 0 : value_of(self)
  end
end


