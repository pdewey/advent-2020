#!/usr/bin/env ruby

BIT_LEN = 36

def build_mask(template)
  mask = {}
  template = template.reverse
  mask[0] = template.enum_for(:scan, /(?=0)/).map { Regexp.last_match.offset(0).first }
  mask[1] = template.enum_for(:scan, /(?=1)/).map { Regexp.last_match.offset(0).first }
  mask
end

def apply_mask(n, mask)
  n = n.to_s(2).reverse
  n += '0' * (BIT_LEN - n.size)
  mask.each do |k, v|
    v.each do |sub|
      n[sub] = k.to_s
    end
  end
  n.reverse.to_i(2)
end

mask = {}
mem = []
file = IO.foreach("input.txt") { |line|
  if line.include? "mask"
    mask = build_mask(line.strip.split(' ')[-1])
    next
  end

  split = line.strip.split(' ')
  n = split[-1].to_i
  mem_loc = split[0].gsub(/[^0-9]/, '').to_i
  mem[mem_loc] = apply_mask(n, mask)
}

puts mem.compact.sum
