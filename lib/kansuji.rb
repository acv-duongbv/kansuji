$first = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
$last = { 0 => '', 1 => '十', 2 => '百', 3 => '千', 4 => '万', 8 => '億', 12 => '兆', 16 => '京',\
          20 => '垓', 24 => '𥝱', 28 => '穣', 32 => '溝', 36 => '澗', 40 => '正', 44 => '載', 48 => '極',\
          52 => '恒河沙', 56 => '恒河沙', 60 => '那由他', 64 => '不可思議', 68 => '無量大数' }
# Convert number to kansuji
class Numeric
  def convert(str)
    return $first[str.to_i] if str.length == 1
    return convert(str[1, str.length - 1]) if str[0] == '0'
    if $last.key?(str.length - 1)
      return (str[0] != '1' ? $first[str[0].to_i] : '') + $last[str.length - 1] \
               + convert(str[1, str.length - 1])
    end
    $last.keys.reverse_each do |key|
      if key <= str.length - 1
        return convert(str[0, str.length - key]) \
                 + $last[key] + convert(str[str.length - key, key])
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
    # str.each_char{|c|  return "Error: #{c} not a kansuji"  if $first.include?(c) == false &&  $last.values.include?(c) == false }
    return 0 if str == '' || str.nil?
    return $first.index(str) if $first.include?(str)
    return (10**$last.key(str)) if $last.value?(str)
    $last.values.reverse.map do |value|
      if str.include?(value)
        return (value_of(str[0, str.index(value)]).equal?(0) ? 1 : value_of(str[0, str.index(value)])) * (10**$last.key(value)) \
                 + value_of(str[str.index(value) + 1, str.length - str.index(value)])
      end
    end
  end

  def to_number
    self == '零' ? 0 : value_of(self)
  end
end
