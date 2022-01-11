roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

arabic_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def to_roman(num,roman_mapping)
  if num==0
    return ''
  elsif roman_mapping.key?(num)
    return roman_mapping[num]
  end
  best=0
  roman_mapping.keys.each do |rom_num|
    if rom_num>best && rom_num<num
      best=rom_num if best<num
    end
  end
  return roman_mapping[best] + to_roman(num-best,roman_mapping) 
end

def to_arabic(rom_str,arabic_mapping)
  if rom_str==''
    return 0
  elsif arabic_mapping.key?(rom_str)
    return arabic_mapping[rom_str]
  end
  return to_arabic(rom_str[1..],arabic_mapping)+arabic_mapping[rom_str[0]]
end

p to_roman(1625,roman_mapping)
p to_arabic('MDCXXV',arabic_mapping)