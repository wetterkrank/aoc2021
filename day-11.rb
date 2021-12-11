# https://adventofcode.com/2021/day/10
# Dumbo Octopus, a cellular automaton

require_relative 'common'

DIRS = [-1, 0, 1].repeated_permutation(2).to_a

class Day11 < AdventDay
  def cycle(grid, step: nil)
    y = grid.size
    x = grid.first.size
    y.times { |j| x.times { |i| grid[j][i] += 1 } }
    y.times { |j| x.times { |i| flash(grid, j, i) } }
    return step + 1 if step
  end

  def count_flashes(grid)
    grid.reduce(0) { |acc, elem| acc + elem.count(0) }
  end

  def flash(grid, y, x)
    return 0 if grid[y][x] <= 9

    grid[y][x] = 0
    DIRS.sum do |dy, dx|
      xn = x + dx
      yn = y + dy
      next 0 if xn.negative? || yn.negative? || xn >= grid.first.size || yn >= grid.size

      grid[yn][xn] += 1 unless grid[yn][xn].zero?
      flash(grid, yn, xn)
    end
  end

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

  def convert_data(data)
    super.map { |line| line.chars.map(&:to_i) }
  end
end

Day11.solve
