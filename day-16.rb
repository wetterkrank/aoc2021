# https://adventofcode.com/2021/day/16
# Packet Decoder -- parsing a string

require_relative 'common'

OPS = {
  0 => ->(a, b) { a + b },
  1 => ->(a, b) { a * b },
  2 => ->(a, b) { [a, b].min },
  3 => ->(a, b) { [a, b].max },
  4 => ->(a, _) { a },
  5 => ->(a, b) { a > b ? 1 : 0 },
  6 => ->(a, b) { a < b ? 1 : 0 },
  7 => ->(a, b) { a == b ? 1 : 0 }
}

class Day16 < AdventDay
  def first_part
    counter = lambda {
      sum = 0
      ->(packet, _) { sum += packet[:version] }
    }
    packets = Parser.new(input).parse
    walk(packets, counter.call)
  end
  
  def second_part
    packets = Parser.new(input).parse
    action = lambda { |packet, values| 
      type = packet[:type]
      values.reduce { |acc, elem| OPS[type].call(acc, elem) } 
    }
    walk(packets, action)
  end
  
  private

  # Walk the hash tree with the supplied fn
  def walk(node, action)
    children = node[:contents]
    return action&.call(node, [children]) unless children.is_a? Array

    contents = children.map { |child| walk(child, action) }
    action&.call(node, contents)
  end

  # Convert hex to bin string; pad with 0s to a length divisible by 4
  def convert_data(data)
    str = super.first
    str.hex.to_s(2).rjust(str.length * 4, '0')
  end
end

class Parser
  def initialize(str)
    @message = str
    @pos = 0
  end

  def parse
    version = read(3)
    type = read(3)
    # If type == 4, we grab the literal and return it right away
    return { version: version, type: type, contents: read_blocks } if type == 4

    subpackets = []
    if read(1).zero?
      # We need to return an unknown number of packets
      # Keep pushing them into an array until we reach @pos + length
      stop_pos = @pos + read(15)
      subpackets << parse while @pos < stop_pos
    else
      # We need to return an array with _length_ packets
      subpackets = read(11).times.map { parse }
    end
    { version: version, type: type, contents: subpackets }
  end

  private

  # Read _count_ bits, update the cursor
  def read(count, as_binary: false)
    str = @message[@pos...@pos + count]
    @pos += count
    as_binary ? str : str.to_i(2)
  end

  # Read literal blocks
  def read_blocks
    str = ''
    loop do
      block = read(5, as_binary: true)
      str += block[1..]
      break if block[0] == '0'
    end
    str.to_i(2)
  end
end

Day16.solve
