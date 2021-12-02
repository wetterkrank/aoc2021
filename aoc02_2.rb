# https://adventofcode.com/2021/day/2
# Steer submarine using directions X, Y and AIM

data = ::File.open('aoc02_input.txt').read.lines(chomp: true)

x, y, =
  data.reduce([0, 0, 0]) do |memo, line|
    x, y, aim = memo
    dir, n = line
    n = n.to_i
    case dir
    when 'up' then [x, y, aim - n]
    when 'down' then [x, y, aim + n]
    when 'forward' then [x + n, y + (aim * n), aim]
    end
  end

puts x * y
