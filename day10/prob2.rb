#!/usr/bin/env ruby

adapters = [0]
file = IO.foreach("prob1.txt") { |line|
  adapters << line.strip.to_i unless line.strip.empty?
}

adapters.sort!
adapters << adapters[-1] + 3

$seen = {}
def find_valid_path(beg, path)
  if path.size == 1
    return 1
  elsif
    $seen[beg] != nil
    return $seen[beg]
  end

  sum = 0
  path.each_with_index do |ele, idx|
    if ele - beg <= 3
      sum += find_valid_path(ele, path[idx+1..-1])
    else
      break
    end
  end
  $seen[beg] = sum
end

puts find_valid_path(adapters[0], adapters[1..-1])
