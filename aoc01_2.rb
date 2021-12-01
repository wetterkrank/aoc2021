# https://adventofcode.com/2021/day/2
# Count times when the next sliding window's sum is larger than the previous'

data = ::File.open('aoc01_input.txt').read.lines(chomp: true).map(&:to_i)

count = data.each_cons(3).each_cons(2).count { |(prev, cur)| cur.sum > prev.sum }

puts count
