#!/usr/bin/env ruby

hill = []
file = IO.foreach("prob1.txt") { |line|
  line = line.strip
  hill << line unless line.empty?
}

x = 0
y = 0
num_trees = 0
while y < hill.count - 1
  x = (x + 3) % hill[0].size
  y += 1
  num_trees += 1 if hill[y][x] == '#'
end

puts num_trees
