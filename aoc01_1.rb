# https://adventofcode.com/2021/day/1
# Count times when next depth measurement is larger than the previous

data = ::File.open('aoc01_input.txt').read.lines(chomp: true).map(&:to_i)

count = 0
data.each_cons(2) { |(previous, current)| count += 1 if current > previous }

puts count
