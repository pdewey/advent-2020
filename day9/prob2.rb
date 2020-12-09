#!/usr/bin/env ruby

PREAMBLE_LEN = 25

avail_nums = []
line_num = 0
target = 0
file = IO.foreach("prob1.txt") { |line|
  if line_num < PREAMBLE_LEN
    avail_nums << line.strip.to_i
    line_num += 1
  else
    target = line.strip.to_i
    found = false
    avail_nums[-PREAMBLE_LEN..-1].each do |a|
      break if found
      avail_nums[-PREAMBLE_LEN+1..-1].each do |b|
        if a + b == target
          found = true
          break
        end
      end
    end
    unless found
      break
    end
    avail_nums << target
  end
}

avail_nums.each_with_index do |val, idx|
  sum = val
  curr_idx = idx + 1
  min = val
  max = val
  while sum < target && curr_idx < avail_nums.size
    sum += avail_nums[curr_idx]
    max = [avail_nums[curr_idx], max].max
    min = [avail_nums[curr_idx], min].min
    curr_idx += 1
  end
  next unless sum == target
  puts "MAX: #{max}, MIN: #{min}, SUM: #{max + min}"
end
