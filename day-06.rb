# https://adventofcode.com/2021/day/6
# Lanternfish: sum up aggregated values (age group total) intead of counting individual ones

require_relative 'common'

class Day6 < AdventDay
  def ages_count(gens)
    ages = input.each_with_object(Array.new(9, 0)) { |fish, arr| arr[fish] += 1 }
    gens.times do
      ages = (0..8).map { |i| ages[(i + 1) % 9] + (i == 6 ? ages[0] : 0) }
    end
    ages.sum
  end

  def first_part
    ages_count(80)
  end

  def second_part
    ages_count(256)
  end

  private

  def convert_data(data)
    super.first.split(',').map(&:to_i)
  end
end

Day6.solve
