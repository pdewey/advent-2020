#!/usr/bin/env ruby

t = 100548715202888
buses = []
File.open("prob2.txt", 'r') do |fh|
  _ = fh.readline.to_i
  buses = fh.readline.strip.split(',')
end

# Find the largest bus length
buses_actual = buses.select { |ch| ch != 'x' }.map(&:to_i)
max_bus, second_bus = buses_actual.sort.reverse[0..1]
max_offset = buses.find_index(max_bus.to_s)


# Find closest starting t
seen = [max_bus.to_s]
t = t + (max_bus - (t % max_bus))
multi = t / max_bus
jump = 1
while true
  t = (max_bus * multi) - max_offset
  buses.each_with_index do |bus, offset|
    next if bus == 'x'
    break if (t + offset) % bus.to_i != 0
    unless seen.include? bus
      jump *= bus.to_i
      seen << bus
    end
    if offset == buses.size - 1
      puts t
      return
    end
  end
  multi += jump
end
