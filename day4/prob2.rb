#!/usr/bin/env ruby

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

def validate(k, v)
  valid = true
  case k
  when "byr"
    valid = false unless v.size == 4 && (1920..2002) === v.to_i
  when "iyr"
    valid = false unless v.size == 4 && (2010..2020) === v.to_i
  when "eyr"
    valid = false unless v.size == 4 && (2020..2030) === v.to_i
  when "hgt"
    valid = true if Integer(v[0..-3]) rescue false
    return false unless valid
    if v[-2..-1] == "in"
      valid = false unless (59..76) === v[0..-3].to_i
    elsif v[-2..-1] == "cm"
      valid = false unless (150..193) === v[0..-3].to_i
    else
      valid = false
    end
  when 'hcl'
    valid = false unless v[0] == '#'
    valid = false unless v[1..-1].size == 6 && v[1..-1].count('a-f0-9') == 6
  when 'ecl'
    valid = false unless ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include? v
  when 'pid'
    valid = false unless v.size == 9
  else
    valid = false
  end

  valid
end

passports = []
curr_passport = {}
file = IO.foreach("prob1.txt") { |line|
  if line.strip.empty?
    passports << curr_passport
    curr_passport = {}
  end

  line = line.strip.split(' ')
  line.each do |field|
    k, v = field.split(':')
    curr_passport[k] = v
  end
}

passports << curr_passport unless curr_passport.empty?

num_valid = 0
passports.each do |passport|
  valid = true
  REQUIRED_FIELDS.each do |field|
    valid = false unless passport.has_key? field
  end

  next unless valid

  passport.each do |k, v|
    next unless REQUIRED_FIELDS.include? k
    valid = validate(k, v)
    break unless valid
  end

  num_valid += 1 if valid
end

puts num_valid
