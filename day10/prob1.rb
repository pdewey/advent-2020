#!/usr/bin/env ruby

adapters = [0]
file = IO.foreach("prob1.txt") { |line|
  adapters << line.strip.to_i unless line.strip.empty?
}

adapters.sort!
adapters << adapters[-1] + 3

one_diff = 0
three_diff = 0
prev_adapt = adapters[0]
adapters.each do |adapter|
  if adapter - prev_adapt == 1
    one_diff += 1
  elsif adapter - prev_adapt == 3
    three_diff += 1
  end

  prev_adapt = adapter
end

puts one_diff * three_diff
