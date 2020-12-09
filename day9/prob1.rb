#!/usr/bin/env ruby

PREAMBLE_LEN = 25

avail_nums = []
line_num = 1
file = IO.foreach("prob1.txt") { |line|
  if line_num <= PREAMBLE_LEN
    avail_nums << line.strip.to_i
    line_num += 1
  else
    target = line.strip.to_i
    found = false
    avail_nums.each do |a|
      break if found
      avail_nums[1..-1].each do |b|
        if a + b == target
          found = true
          break
        end
      end
    end
    unless found
      puts "#{target}"
      return
    end
    avail_nums.shift
    avail_nums << target
  end
}
