# https://adventofcode.com/2021/day/7
# The Treachery of Whales: sum of arithmetic progression (aka arithmetic series)

require_relative 'common'

class Day7 < AdventDay
  def min_cost(&block)
    costs = input.map { |pos| input.reduce(0) { |acc, elem| acc + yield(elem, pos) } }
    costs.min
  end

  def first_part
    min_cost { |a, b| (a - b).abs }
  end

  def second_part
    min_cost { |a, b| ((1 + (a - b).abs) * (a - b).abs) / 2 }
  end

  private

  def convert_data(data)
    super.first.split(',').map(&:to_i)
  end
end

Day7.solve
