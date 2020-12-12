#!/usr/bin/env ruby

course = []
file = IO.foreach("prob1.txt") { |line|
  course << line.strip unless line.strip.empty?
}

def turn(dir, delta)
  sign = delta[0] == 'L' ? -1 : 1
  mag = sign * delta[1..-1].to_i
  compass = {
    'N' => 0,
    'E' => 90,
    'S' => 180,
    'W' => 270
  }

  compass.select { |k, v| v == (compass[dir] + mag) % 360 }.keys.first
end

def move(dir, coords, delta)
  command = delta[0]
  mag = delta[1..-1].to_i
  x, y = coords

  command = command == 'F' ? dir : command
  if ['L', 'R'].include? command
    [turn(dir, delta), coords]
  elsif command == 'N'
    [dir, [x, y + mag]]
  elsif command == 'E'
    [dir, [x + mag, y]]
  elsif command == 'S'
    [dir, [x, y - mag]]
  elsif command == 'W'
    [dir, [x - mag, y]]
  end
end

dir = 'E'
coords = [0, 0]
course.each do |step|
  dir, coords = move(dir, coords, step)
end

puts coords[0].abs + coords[1].abs
