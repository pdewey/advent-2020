#!/usr/bin/env ruby

MAX_ROW = 127
MAX_COL = 7
ID_COEFF = 8

seats = []
file = IO.foreach("prob1.txt") { |line|
  seats << line.strip unless line.strip.empty?
}

def binary_search(lo, hi, s)
  ch = s[0]
  if ['F', 'L'].include? ch
    return lo if s.size == 1
    return binary_search(lo, (lo + hi) / 2, s[1..-1])
  elsif ['B', 'R'].include? ch
    return hi if s.size == 1
    return binary_search(((lo + hi) / 2.to_f).ceil, hi, s[1..-1])
  end
end

ids = []
seats.each do |seat|
  row = binary_search(0, MAX_ROW, seat[0, 7])
  col = binary_search(0, MAX_COL, seat[7..-1])

  ids << (ID_COEFF * row) + col
end

ids.sort!

ids.each_with_index do |val, idx|
  next if idx == 0
  if val - ids[idx-1] != 1
    puts "Seat id: #{val - 1}"
    break
  end
end
