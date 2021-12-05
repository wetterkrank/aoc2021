# https://adventofcode.com/2021/day/5
# Hydrothermal Venture: turning line ends' coordinates into points in the sparse array

require_relative 'common'

class Day5 < AdventDay
  def first_part
    dots = lines2dots(input)
    count_2d_hash_values(dots) { |x| x >= 2 }
  end

  def second_part
    dots = lines2dots(input, diagonals: true)
    count_2d_hash_values(dots) { |x| x >= 2 }
  end

  def line(coords, diagonals)
    x1, x2, y1, y2 = coords.values_at(:x1, :x2, :y1, :y2)
    dx = x2 - x1 # delta x with sign, can be 0
    dy = y2 - y1 # delta y with sign, can be 0
    return unless (dx.zero? || dy.zero?) || (diagonals && dx.abs == dy.abs)
    
    length = [dx.abs, dy.abs].max + 1
    a = dx <=> 0 # -1, 0, +1
    b = dy <=> 0 # -1, 0, +1
    length.times.map { |t| [x1 + (a * t), y1 + (b * t)] }
  end

  def lines2dots(data, diagonals: false)
    init = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = 0 } }
    data.each_with_object(init) do |coords, obj|
      line(coords, diagonals)&.each { |(x, y)| obj[y][x] += 1 }
    end
  end

  def count_2d_hash_values(hash)
    return unless block_given?

    hash.keys.reduce(0) do |acc, key1| 
      acc + hash[key1].keys.count { |key2| yield(hash[key1][key2]) }
    end
  end

  private

  def convert_data(data)
    super.map do |line|
      /^(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)$/ =~ line
      { x1: x1.to_i, y1: y1.to_i, x2: x2.to_i, y2: y2.to_i }
    end
  end
end

Day5.solve
