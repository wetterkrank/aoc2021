# https://adventofcode.com/2021/day/22
# Reactor Reboot

require_relative 'common'

class Day22 < AdventDay
  def first_part
    space = input.each_with_object({}) do |instruction, obj|
      cube, mode = instruction
      next if cube.any? { |edge| edge.first.abs > 50 }

      xr, yr, zr = cube
      xr.each { |x| yr.each { |y| zr.each { |z| obj[[x, y, z]] = mode } } }
    end
    space.values.count(true)
  end

  def second_part
    input.each_with_index.reduce(0) do |acc, (instruction, i)|
      cube, mode = instruction
      rest = input[i + 1..].map(&:first)
      mode ? acc + get_volume(cube, rest) : acc
    end
  end
  
  private

  def get_volume(cube, rest)
    intersections = rest.each_with_object([]) do |other_cube, arr|
      intersection = intersect(cube, other_cube)
      arr << intersection unless intersection.empty?
    end

    intersections.each_with_index.reduce(volume(cube)) do |vol, (int, i)| 
      vol - get_volume(int, intersections[i + 1..])
    end
  end

  def overlap(one, other)
    xr = ([one.min, other.min].max)..([one.max, other.max].min)
    xr.last >= xr.first ? xr : nil
  end

  def intersect(cube1, cube2)
    axes = cube1.zip(cube2).map { |(axis1, axis2)| overlap(axis1, axis2) }
    axes.any?(nil) ? [] : axes
  end

  def volume(edges)
    return 0 if edges.nil? || edges.empty?

    edges.reduce(1) { |acc, elem| acc * elem.size }
  end

  def convert_data(data)
    super.map do |line| 
      setting, ranges = line.split 
      axes = ranges.split(',').map { eval(_1[2..]) }
      [axes, setting == 'on']
    end
  end
end

Day22.solve
