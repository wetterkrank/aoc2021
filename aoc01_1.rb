# https://adventofcode.com/2021/day/1
# Count times when next depth measurement is larger than the previous

data = File.open('aoc01_input.txt').read.lines(chomp: true).map(&:to_i)

count = 0
data.each_cons(2) { |pair| count += 1 if pair[1] > pair[0] }

puts count
