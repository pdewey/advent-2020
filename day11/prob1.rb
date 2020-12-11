#!/usr/bin/env ruby

EMPTY = 'L'
OCCUP = '#'
FLOOR = '.'

def get_num_adjacent_seats(rows, x, y)
  count = 0
  max_x = x == rows[0].size - 1 ? x : x + 1
  max_y = y == rows.size - 1 ? nil : y + 1
  min_y = y == 0 ? nil : y - 1
  min_x = x == 0 ? x : x - 1
  # Get top row
  unless min_y == nil
    count += rows[min_y][min_x..max_x].count(OCCUP)
  end
  # Get center row
  if x > 0
    count += 1 if rows[y][x - 1] == OCCUP
  end
  if x < rows[y].size - 1
    count += 1 if rows[y][x + 1] == OCCUP
  end
  # Get last row
  unless max_y == nil
    count += rows[max_y][min_x..max_x].count(OCCUP)
  end

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
      if seat == EMPTY && get_num_adjacent_seats(rows, x, y) == 0
        temp_rows[y][x] = OCCUP
        was_changed = true
      elsif seat == OCCUP && get_num_adjacent_seats(rows, x, y) >= 4
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
