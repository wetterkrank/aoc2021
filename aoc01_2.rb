# https://adventofcode.com/2021/day/2
# Count times when the next sliding window's sum is larger than the previous'

data = File.open('aoc01_input.txt').read.lines(chomp: true).map(&:to_i)

count = 0
previous = data[0..2].sum

data.each_cons(3) do |window|
  sum = window.sum
  count += 1 if sum > previous
  previous = sum
end

puts count
