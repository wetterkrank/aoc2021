# https://adventofcode.com/2021/day/9
# Smoke Basin

require_relative 'common'

class Day9 < AdventDay
  DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  # gets cell neighbours in DIRS directions, returns object { h: cell_value, x: ..., y: ... }
  def neighbours(grid, y, x)
    DIRS.each_with_object([]) do |(dy, dx), list| 
      xn = x + dx
      yn = y + dy
      nbr = xn >= 0 && yn >= 0 ? grid.dig(yn, xn) : nil # mind those negative array indices in Ruby
      list << { h: nbr, y: yn, x: xn } unless nbr.nil?
    end
  end

  # recursively walks the surrounding cells except those in .reject; nils all visited cells
  def map_nbrhood(grid, current)
    y, x = current.values_at(:y, :x)
    return 0 if grid[y][x].nil?

    nbrs = neighbours(grid, y, x)
    nbrs = nbrs.reject { |nbr| nbr[:h] == 9 }
    grid[y][x] = nil
    return 1 if nbrs.empty?

    nbrs.sum { |nbr| map_nbrhood(grid, nbr) } + 1
  end

  def first_part
    grid = input.dup
    grid.each_with_index.sum do |row, y|
      row.each_with_index.sum do |point, x|
        nbrs = neighbours(grid, y, x)
        nbrs.all? { |nbr| nbr[:h] > point } ? point + 1 : 0
      end
    end
  end

  def second_part
    grid = input.dup
    basin_sizes = grid.each_with_object([]).with_index do |(row, acc), y|
      row.each_with_index do |num, x|
        acc << map_nbrhood(grid, { h: num, y: y, x: x }) unless num.nil? || num == 9
      end
    end
    basin_sizes.sort.last(3).reduce(:*)
  end

  private

  def convert_data(data)
    super.map { |line| line.chars.map(&:to_i) }
  end
end

Day9.solve
