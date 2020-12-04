#!/usr/bin/env ruby

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

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

  num_valid += 1 if valid
end

puts num_valid
