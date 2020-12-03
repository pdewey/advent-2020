#!/usr/bin/env ruby

count = 0
file = IO.foreach("prob1.txt") { |line|
  split = line.split(' ')
  range = split[0].split('-')
  min = range[0].to_i
  max = range[1].to_i
  needle = split[1][0, split[1].size - 1]
  haystack = split[2]

  count += 1 if haystack.count(needle) <= max && haystack.count(needle) >= min
}

puts count
