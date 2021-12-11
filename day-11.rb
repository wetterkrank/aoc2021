# https://adventofcode.com/2021/day/10
# Dumbo Octopus, a cellular automaton

require_relative 'common'

DIRS = [-1, 0, 1].repeated_permutation(2).to_a

class Day11 < AdventDay
  def first_part
    grid = input
    100.times.sum do 
      cycle(grid)
      count_flashes(grid)
    end
  end

  def second_part
    grid = input
    (1..).find do 
      cycle(grid)
      count_flashes(grid) == 100
    end
  end

  private

  def cycle(grid, step: nil)
    grid.each_key { |coords| grid[coords] += 1 }
    grid.each_key { |coords| flash(grid, *coords) }
    return step + 1 if step
  end

  def flash(grid, x, y)
    return 0 if grid[[x, y]].nil? || grid[[x, y]] <= 9

    grid[[x, y]] = 0
    DIRS.sum do |dx, dy|
      adjacent = [x + dx, y + dy]
      grid[adjacent] += 1 unless grid[adjacent].nil? || grid[adjacent].zero?
      flash(grid, *adjacent)
    end
  end

  def count_flashes(grid)
    grid.reduce(0) { |acc, elem| acc + elem.count(0) }
  end

  def convert_data(data)
    super.each_with_object({}).with_index do |(line, obj), j|
      line.chars.each_with_index do |char, i|
        obj[[j, i]] = char.to_i
      end
    end
  end
end

Day11.solve
