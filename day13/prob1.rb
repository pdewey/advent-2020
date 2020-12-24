#!/usr/bin/env ruby

t = 0
buses = []
File.open("prob1.txt", 'r') do |fh|
  t = fh.readline.to_i
  buses = fh.readline.strip.split(',').select { |ch| ch != 'x' }
end

min = [buses[0], Float::INFINITY]
buses.map(&:to_i).each do |bus|
  lo = t / bus
  hi = bus * (lo + 1)

  delta = hi - t
  if delta < min[1]
    min = [bus, delta]
  end
end

puts min[0] * min[1]
