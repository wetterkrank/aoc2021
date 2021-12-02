# https://adventofcode.com/2021/day/2
# Steer submarine using directions X, Y

data = ::File.open('aoc02_input.txt').read.lines(chomp: true)

data_x, data_y = data.partition { |line| /forward/ =~ line }

x = data_x.reduce(0) { |acc, elem| acc + elem.split.last.to_i }
y = data_y.reduce(0) { |acc, elem| elem.split.first == 'down' ? acc + elem.split.last.to_i : acc - elem.split.last.to_i }

puts x * y
