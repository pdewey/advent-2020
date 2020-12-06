#!/usr/bin/env ruby
require 'set'

answers = Set.new
sum = 0
file = IO.foreach("prob1.txt") { |line|
  if line.strip.empty?
    sum += answers.size
    answers.clear
  end

  line.strip.chars.each { |ch| answers << ch }
}

sum += answers.size unless answers.empty?
puts sum
