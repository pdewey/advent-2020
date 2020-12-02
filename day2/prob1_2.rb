#!/usr/bin/env ruby

count = 0
file = IO.foreach("prob1_1.txt") { |line|
  split = line.split(' ')
  range = split[0].split('-')
  pos1 = range[0].to_i - 1 # not zero indexed
  pos2 = range[1].to_i - 1
  needle = split[1][0, split[1].size - 1]
  haystack = split[2]

  if (haystack[pos1] == needle && haystack[pos2] != needle) ||
     (haystack[pos1] != needle && haystack[pos2] == needle)
     count += 1
  end
}

puts count
