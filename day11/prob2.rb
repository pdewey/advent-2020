#!/usr/bin/env ruby

EMPTY = 'L'
OCCUP = '#'
FLOOR = '.'

def get_diag_up_left_seat(rows, x, y)
  found = nil
  x -= 1
  y -= 1
  while x >= 0 && y >= 0 && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x -= 1
    y -= 1
  end

  return found == nil ? 0 : found
end

def get_diag_up_right_seat(rows, x, y)
  found = nil
  x += 1
  y -= 1
  while y >= 0 && x < rows[0].size && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x += 1
    y -= 1
  end

  return found == nil ? 0 : found
end

def get_up_seat(rows, x, y)
  found = nil
  y -= 1
  while y >= 0 && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    y -= 1
  end

  return found == nil ? 0 : found
end

def get_left_seat(rows, x, y)
  found = nil
  x -= 1
  while x >= 0 && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x -= 1
  end

  return found == nil ? 0 : found
end

def get_right_seat(rows, x, y)
  found = nil
  x += 1
  while x < rows[0].size && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x += 1
  end

  return found == nil ? 0 : found
end

def get_diag_down_left_seat(rows, x, y)
  found = nil
  x -= 1
  y += 1
  while x >= 0 && y < rows.size && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x -= 1
    y += 1
  end

  return found == nil ? 0 : found
end

def get_diag_down_right_seat(rows, x, y)
  found = nil
  x += 1
  y += 1
  while x < rows[0].size && y < rows.size && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    x += 1
    y += 1
  end

  return found == nil ? 0 : found
end

def get_down_seat(rows, x, y)
  found = nil
  y += 1
  while y < rows.size && found == nil
    found = 1 if rows[y][x] == OCCUP
    found = 0 if rows[y][x] == EMPTY
    y += 1
  end

  return found == nil ? 0 : found
end

def get_num_visible_seats(rows, x, y)
  count = 0
  count += get_diag_up_left_seat(rows, x, y)
  count += get_diag_up_right_seat(rows, x, y)
  count += get_up_seat(rows, x, y)
  count += get_left_seat(rows, x, y)
  count += get_right_seat(rows, x, y)
  count += get_diag_down_left_seat(rows, x, y)
  count += get_diag_down_right_seat(rows, x, y)
  count += get_down_seat(rows, x, y)

  count
end


rows = []
file = IO.foreach("prob1.txt") { |line|
  rows << line.strip unless line.strip.empty?
}

temp_rows = []
was_changed = true
while was_changed
  was_changed = false
  rows.each_with_index do |row, y|
    temp_rows << row.clone
    row.chars.each_with_index do |seat, x|
      if seat == EMPTY && get_num_visible_seats(rows, x, y) == 0
        temp_rows[y][x] = OCCUP
        was_changed = true
      elsif seat == OCCUP && get_num_visible_seats(rows, x, y) >= 5
        temp_rows[y][x] = EMPTY
        was_changed = true
      end
    end
  end
  rows = temp_rows.clone
  temp_rows.clear
end

count = 0
rows.each do |row|
  count += row.count(OCCUP)
end

puts count
