# https://adventofcode.com/2021/day/12
# Passage Pathing, counting graph paths

require_relative 'common'

class Day12 < AdventDay
  def first_part
    count_paths(input, 'start', {})
  end
  
  def second_part
    # Extra condition -- allow only one "small" cave visited twice
    constraint = ->(node, path) { path[node] == 1 && path.values.none? { |val| val == 2 } }
    count_paths(input, 'start', {}, constraint)
  end

  private

  def big?(node)
    node.chars.first <= 'Z'
  end

  def count_paths(adj, curr, visited, constraint = nil)
    return 1 if curr == 'end'

    visited[curr] = visited[curr].nil? ? 1 : visited[curr] + 1 unless big?(curr)
    # Allow big caves and small caves not visited yet + extra condition if given
    next_nodes = adj[curr].filter do |node|
      node != 'start' && (visited[node].nil? || big?(node) || constraint&.call(node, visited))
    end
    next_nodes.sum { |node| count_paths(adj, node, visited.dup, constraint) }
  end

  def convert_data(data)
    pair = super.map { _1.split('-') }
    pair.each_with_object({}) do |(a, b), map|
      map[a] = map[a].nil? ? [b] : map[a] << b
      map[b] = map[b].nil? ? [a] : map[b] << a
    end
  end
end

Day12.solve
