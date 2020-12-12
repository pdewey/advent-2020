#!/usr/bin/env ruby

course = []
file = IO.foreach("prob1.txt") { |line|
  course << line.strip unless line.strip.empty?
}

def rotate(ship_coords, way_coords, delta)
  sign = delta[0] == 'L' ? -1 : 1
  deg = delta[1..-1].to_i
  way_x, way_y = way_coords

  while deg != 0
    temp_x = way_x
    temp_y = way_y
    if sign == 1
      way_x = temp_y
      way_y = temp_x * -1
    else
      way_x = temp_y * -1
      way_y = temp_x
    end
    deg -= 90
  end
  [way_x, way_y]
end

def move_waypoint(ship_coords, way_coords, delta)
  command = delta[0]
  mag = delta[1..-1].to_i
  ship_x, ship_y = ship_coords
  way_x, way_y = way_coords

  if ['L', 'R'].include? command
    [ship_coords, rotate(ship_coords, way_coords, delta)]
  elsif command == 'N'
    [ship_coords, [way_x, way_y + mag]]
  elsif command == 'E'
    [ship_coords, [way_x + mag, way_y]]
  elsif command == 'S'
    [ship_coords, [way_x, way_y - mag]]
  elsif command == 'W'
    [ship_coords, [way_x - mag, way_y]]
  elsif command == 'F'
    ship_x += way_x * mag
    ship_y += way_y * mag
    [[ship_x, ship_y], way_coords]
  end
end

ship = [0, 0]
waypoint = [10, 1]
course.each do |step|
  ship, waypoint = move_waypoint(ship, waypoint, step)
end
puts ship[0].abs + ship[1].abs
