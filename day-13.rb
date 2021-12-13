# https://adventofcode.com/2021/day/13
# Transparent Origami

require_relative 'common'

class Day13 < AdventDay
  def first_part
    coords, instructions = input.dup
    fold(coords, instructions.first).count
  end

  def second_part
    coords, instructions = input.dup
    result = instructions.reduce(coords) { |acc, elem| fold(acc, elem) }
    pretty_print(result)
  end

  private
  
  def fold(sheet, (axis, fold))
    sheet.map do |coords|
      n = coords[axis]
      coords[axis] = n < fold ? n : (2 * fold) - n
      coords
    end.uniq
  end

  def convert_data(data)
    coords, instructions = data.split("\n\n")
    [
      coords.lines(chomp: true).map { _1.split(',') }.map { _1.map(&:to_i) },
      instructions.lines(chomp: true)
                  .map { _1.split.last.split('=') }
                  .map { |ax, str| [ax == 'x' ? 0 : 1, str.to_i] }
    ]    
  end

  def pretty_print(grid)
    x, y = grid.reduce([0, 0]) { |acc, elem| [[acc.first, elem.first].max, [acc.last, elem.last].max] }
    (y + 1).times do |j|
      (x + 1).times do |i|
        print grid.include?([i, j]) ? '#' : '.'
      end
      print "\n"
    end
  end
end

Day13.solve
