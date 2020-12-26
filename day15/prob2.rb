#!/usr/bin/env ruby

LAST_TURN = 30000000

preamble = []
file = IO.foreach("input.txt") { |line|
  preamble = line.strip.split(',').map(&:to_i)
}

def init_last_seen(preamble)
  last_seen = {}
  preamble.each.with_index(1) do |n, idx|
    last_seen[n] = [idx]
  end
  last_seen
end

last_seen = init_last_seen(preamble)
prev = preamble[-1]
(preamble.size + 1..LAST_TURN).each do |turn|
  puts "Calculating turn: #{turn}"
  if last_seen[prev].size == 1
    curr = 0
  else last_seen[prev].size > 1
    curr = last_seen[prev][-1] - last_seen[prev][-2]
  end

  last_seen[curr] = [] unless last_seen.include? curr
  last_seen[curr] << turn
  last_seen[curr].shift if last_seen[curr].size > 2
  prev = curr
end

puts prev
