$first = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
$last = {0=>"", 1=>"十", 2=>"百", 3=>"千", 4=>"万", 8=>"億", 12=>"兆", 16=>"京", 20=>"垓", 24=>"𥝱", 28=>"穣", 32=>"溝", 36=>"澗", 40=>"正", 44=>"載", 48=>"極", 52=>"恒河沙", 56=>"阿僧祇", 60=>"那由他", 64=> "不可思議", 68=>"無量大数" }

class Numeric
  def convert(str)
    return $first[str.to_i] if str.length == 1
    return convert(str[1, str.length-1]) if str[0] == '0'
    return (str[0] != '1' ? $first[str[0].to_i] : "") + $last[str.length-1] + convert(str[1, str.length-1]) if $last.key?(str.length-1) 
    $last.keys.reverse.each{ |key| return convert(str[0, str.length-key]) + $last[key] + convert(str[str.length-key, key])  if key <= str.length-1}
  end
  def to_kansuji
    self == 0 ? '零' : convert(self.to_s)
  end
end
