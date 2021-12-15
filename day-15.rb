require 'colorize'
require_relative 'common'

DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]] # clockwise
# DIRS = [[0, 1], [1, 0]] # right and down only

class Day15 < AdventDay
  def first_part
    grid, dims = input.dup
    start = [0, 0]
    target = [dims[0] - 1, dims[1] - 1]

    infinity = dims[0] * dims[1] * 9
    distances = grid.dup.transform_values { |_v| infinity }
    distances[start] = 0
    queue = Set.new(grid.keys)
    current = start

    until current == target || queue.empty?
      nbrs = get_adjacent(current, queue) # get all still unvisited neigbours

      nbrs.each do |nbr|
        distance = distances[current] + grid[nbr] # calc distances through current node
        distances[nbr] = [distances[nbr], distance].min # update distance for each if it's smaller than recorded
      end

      queue.delete(current)
      next_node = queue.min_by { |k| distances[k] } # select node with the smallest distance from the queue
      current = next_node
    end
    distances[target]
  end

  def get_adjacent(position, queue)
    y, x = position
    nbrs = DIRS.map { |dy, dx| [y + dy, x + dx] }
    nbrs.filter { |point| queue === point }
  end

  private

  def pretty_print(grid, dims, path = {})
    y, x = dims
    y.times do |y|
      x.times do |x|
        print grid[[y, x]].to_s.colorize(color: path.key?([y, x]) ? :red : :light_black)
      end
      puts
    end
  end

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

def second_part
end

Day15.solve
