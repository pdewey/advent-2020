#!/usr/bin/env ruby

BIT_LEN = 36

def build_mask(template)
  mask = {}
  template = template.reverse
  mask['X'] = template.enum_for(:scan, /(?=X)/).map { Regexp.last_match.offset(0).first }
  mask['1'] = template.enum_for(:scan, /(?=1)/).map { Regexp.last_match.offset(0).first }
  mask
end

def get_addrs(floating, pos_list, n)
  if pos_list.empty?
    $mem[floating.reverse.to_i(2)] = n
    return
  end

  ['0', '1'].each do |b|
    floating[pos_list.first] = b
    get_addrs(floating, pos_list[1..-1], n)
  end
end


def apply_mask(loc, mask, n)
  loc = loc.to_s(2).reverse
  loc += '0' * (BIT_LEN - loc.size)
  mask.each do |k, v|
    v.each do |sub|
      loc[sub] = k
    end
  end
  get_addrs(loc, mask['X'], n)
end

mask = {}
$mem = {}
file = IO.foreach("input.txt") { |line|
  if line.include? "mask"
    mask = build_mask(line.strip.split(' ')[-1])
    next
  end

  split = line.strip.split(' ')
  n = split[-1].to_i
  mem_loc = split[0].gsub(/[^0-9]/, '').to_i
  apply_mask(mem_loc, mask, n)
}

puts $mem.values.sum
