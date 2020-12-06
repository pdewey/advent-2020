#!/usr/bin/env ruby

answers = Hash.new(0)
num_people = 0
sum = 0
file = IO.foreach("prob1.txt") { |line|
  if line.strip.empty?
    answers.each do |k, v|
      sum += 1 if v == num_people
    end
    answers.clear
    num_people = 0
    next
  end

  num_people += 1
  line.strip.chars.each { |ch| answers[ch] += 1 }
}

unless answers.empty?
  answers.each do |k, v|
    sum += 1 if v == num_people
  end
end

puts sum
