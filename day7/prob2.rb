#!/usr/bin/env ruby

TARGET = 'shiny gold'

$bags = Hash.new {}
num_bags = 0
def find_bags(bag)
  if $bags[bag].empty?
    return 0
  end

  sum = 0
  $bags[bag].each do |next_bag, count|
    found = find_bags(next_bag)
    sum += count +  count * found
  end
  sum
end

file = IO.foreach("prob1.txt") { |line|
  line = line.split('contain')
  curr_bag = line[0].split(' ')[0..1].join(' ')
  $bags[curr_bag] = {}

  line[1].split(',').each do |bag|
    split_bag = bag.split(' ')
    $bags[curr_bag][bag.split(' ')[1..2].join(' ')] = Integer(split_bag[0]) unless bag.include? 'no other bags'
  end
}

puts find_bags(TARGET)
