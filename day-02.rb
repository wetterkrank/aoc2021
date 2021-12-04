# https://adventofcode.com/2021/day/2
# Dive! Steering a submarine (day 1: X, Y // day 2: X, Y, aim)

require_relative 'common'

class Day2 < AdventDay
  def first_part
    data_x, data_y = input.partition { |line| /forward/ =~ line }
    x = data_x.reduce(0) { |acc, elem| acc + elem.split.last.to_i }
    y =
      data_y.reduce(0) do |acc, elem|
        elem.split.first == 'down' ? acc + elem.split.last.to_i : acc - elem.split.last.to_i
      end
    x * y
  end

  def second_part
    x, y, = input.reduce([0, 0, 0]) do |memo, line|
      x, y, aim = memo
      dir, n = line.split
      n = n.to_i
      case dir
      when 'up' then [x, y, aim - n]
      when 'down' then [x, y, aim + n]
      when 'forward' then [x + n, y + (aim * n), aim]
      else raise('Weird input')
      end
    end
    x * y
  end

  private

  def convert_data(data)
    super
  end
end

Day2.solve
