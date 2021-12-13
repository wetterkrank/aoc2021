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

  def convert_data(data)
    coords, instructions = data.split("\n\n")
    [
      coords.lines(chomp: true).map { _1.split(',') }.map { |x, y| [x.to_i, y.to_i] },
      instructions.lines(chomp: true).map { _1.gsub('fold along ', '').split('=') }
                  .map { |ax, str| [ax, str.to_i] }
    ]    
  end

  def fold(sheet, (axis, fold))
    sheet.map do |x, y|
      if axis == 'y'
        y = y < fold ? y : y - (2 * (y - fold))
      else
        x = x < fold ? x : x - (2 * (x - fold))
      end
      [x, y]
    end.uniq
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
