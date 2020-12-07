#!/usr/bin/env ruby

TARGET = 'shiny gold'

$bags = Hash.new []
num_bags = 0
def find_bag(bag, target)
  if bag == target
    return true
  end
  $bags[bag].each do |next_bag|
    found = find_bag(next_bag, target)
    return found if found
  end
  false
end

file = IO.foreach("prob1.txt") { |line|
  line = line.split('contain')
  curr_bag = line[0].split(' ')[0..1].join(' ')
  $bags[curr_bag] = []

  line[1].split(',').each do |bag|
    $bags[curr_bag] << bag.split(' ')[1..2].join(' ') unless bag == 'no other bags.'
  end
}

$bags.each do |k, v|
  next if k == TARGET
  num_bags += 1 if find_bag(k, TARGET)
end

puts num_bags
