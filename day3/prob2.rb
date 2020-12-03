#!/usr/bin/env ruby

hill = []
file = IO.foreach("prob1.txt") { |line|
  line = line.strip
  hill << line unless line.empty?
}

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]


prod = 1
slopes.each do |x_slope, y_slope|
  x = 0
  y = 0
  num_trees = 0
  while y < hill.count - 1
    x = (x + x_slope) % hill[0].size
    y += y_slope
    num_trees += 1 if hill[y][x] == '#'
  end
  prod *= num_trees
end

puts prod
