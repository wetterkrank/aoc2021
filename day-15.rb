# https://adventofcode.com/2021/day/15
# Chiton -- finding the shortest path in a graph

require_relative 'common'

DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

class Day15 < AdventDay
  def first_part
    grid, dims = input.dup
    shortest_path(grid, dims)
  end

  def second_part
    grid, dims = supersize
    shortest_path(grid, dims)
  end

  def shortest_path(grid, dimensions)
    target = [dimensions.first - 1, dimensions.last - 1]
    start = [0, 0]

    distances = { start => 0 }
    queue = Set.new([start])
    current = start

    until queue.empty?
      nbrs = get_adjacent(current, grid)
      nbrs.each do |nbr|
        alt = distances[current] + grid[nbr]
        if distances[nbr].nil? || distances[nbr] > alt
          distances[nbr] = alt
          queue << nbr
        end
      end  
      queue.delete(current)
      current = queue.first
    end

    distances[target]
  end

  def get_adjacent(position, grid)
    y, x = position
    nbrs = DIRS.map { |dy, dx| [y + dy, x + dx] }
    nbrs.reject { |nbr| grid[nbr].nil? }
  end

  def supersize(factor = 5)
    grid, dims = input.dup
    dim_y, dim_x = dims
    megagrid = {}
    factor.times do |j|
      factor.times do |i|
        grid.each_entry do |(y, x), v|
          nv = (v + i + j) > 9 ? (v + i + j) % 9 : v + i + j
          megagrid[[y + (dim_y * j), x + (dim_x * i)]] = nv
        end
      end
    end
    [megagrid, [dim_y * factor, dim_x * factor]]
  end

  private

  def convert_data(data)
    space = {}
    super.each_with_index do |row, y|
      row.chars.each_with_index do |ch, x|
        space[[y, x]] = ch.to_i
      end
    end
    [space, [super.size, super.first.size]]
  end
end

Day15.solve
