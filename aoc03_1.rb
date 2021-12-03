# https://adventofcode.com/2021/day/3

data = ::File.open('aoc03_input.txt').read.lines(chomp: true)

freqs = ::Array.new(12, 0)
data.each do |line|
  line.chars.each.with_index { |char, i| freqs[i] += char.to_i }
end

epsilon = freqs.map { |ones| ones > data.length - ones ? '1' : '0' }.join.to_i(2)
gamma = (~epsilon) & ((1 << freqs.length) - 1)

p epsilon * gamma
