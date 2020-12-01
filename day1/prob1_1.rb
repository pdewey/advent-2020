#!/usr/bin/env ruby

TARGET = 2020
entries = []
file = IO.foreach("prob1_1.txt") { |line|
  entries << line.to_i
}

entries.sort!

prod = 0
found = false
entries.each_with_index do |val1, idx|
  if idx == entries.size - 1
    puts "Index is out of bounds"
    break
  end

  entries[idx + 1, entries.size].each do |val2|
    if val1 + val2 == TARGET
      prod = val1 * val2
      found = true
    end
  end

  break if found
end

puts prod
