require_relative 'common'

class Day12 < AdventDay

  def stop?(node, path)
    node.chars.first > 'Z' && path.include?(node)
  end

  def find_paths(adj, current, path, paths, &block)
    path << current
    puts "Return: #{path}\n" if current == 'end'
    return paths << path if current == 'end'
    
    next_nodes = adj[current].dup
    next_nodes.reject! { |node| yield(node, path) unless node == 'end' }
    
    # puts "Path: #{path}"
    # puts "#{current} -> #{next_nodes} (rejected: #{adj[current] - next_nodes})\n"

    next_nodes.each do |node|
      find_paths(adj, node, path.dup, paths, &block)
    end
    paths.count
  end

  def first_part
    find_paths(input, 'start', [], []) { |node, path| node.chars.first > 'Z' && path.include?(node) }
  end

  def second_part
  end

  private

  def convert_data(data)
    pair = super.map { _1.split('-') }
    pair.each_with_object({}) do |(a, b), map|
      map[a] = map[a].nil? ? [b] : map[a] << b
      # unless %w[start end].include? a
        map[b] = map[b].nil? ? [a] : map[b] << a
      # end
    end
  end
end

Day12.solve
