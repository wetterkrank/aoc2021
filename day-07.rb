# https://adventofcode.com/2021/day/7
# The Treachery of Whales: sum of arithmetic progression (aka arithmetic series)

require_relative 'common'

class Day7 < AdventDay
  def first_part
    distances = (input.min..input.max).map do |pos| 
      input.reduce(0) { |acc, elem| acc + (elem - pos).abs }
    end
    distances.min
  end

  def second_part
    distances = (input.min..input.max).map do |pos|
      input.reduce(0) do |acc, elem|
        n = (elem - pos).abs
        acc + (((1 + n) * n) / 2)
      end
    end
    distances.min
  end

  private

  def convert_data(data)
    super.first.split(',').map(&:to_i)
  end
end

Day7.solve
