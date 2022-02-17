require_relative 'common'

OPS = {
  0 => ->(a, b) { a + b},
  1 => ->(a, b) { a * b},
  2 => ->(a, b) { [a, b].min },
  3 => ->(a, b) { [a, b].max },
  4 => ->(a, _) { a },
  5 => ->(a, b) { a > b ? 1 : 0 },
  6 => ->(a, b) { a < b ? 1 : 0 },
  7 => ->(a, b) { a == b ? 1 : 0 }
}

class Day16 < AdventDay
  def first_part
    packets = Parser.new(input).parse
    Walker.walk(packets, ->(packet) { packet[:version] }, ->(versions) { versions.reduce(:+) })
  end
  
  def second_part
    # packets = Parser.new(input).parse
    # grabr = ->(packet) { packet[:contents] if packet[:contents].is_a? Array }
    # procesr = ->(packet, values) { 
    #   type = packet[:type]
    #   values.reduce { |acc, elem| OPS[type] } 
    # }
  end
  
  private

  # convert hex to bin string with 0-padding to a divisible by 4
  def convert_data(data)
    str = super.first
    str.hex.to_s(2).rjust(str.length * 4, '0')
  end
end

class Parser
  def initialize(str)
    puts "Input: #{str}"
    puts "Total bits: #{str.length}"

    @message = str
    @pos = 0
  end

  def parse
    return if @pos + 6 >= @message.length # is it even needed?

    print "Pos: #{@pos} -> "
    version = read(3)
    type = read(3)
    print "version: #{version}, type: #{type}\n"

    # if type == 4, we grab the literal and return it right away
    return { version: version, type: type, contents: read_blocks } if type == 4

    subpackets = []
    mode = read(1)
    if mode.zero?
      # We need to return an unknown number of packets
      # Let's keep pushing them into an array until we reach @pos + length
      length = read(15)
      stop_pos = @pos + length
      subpackets << parse while @pos < stop_pos
    else
      length = read(11)
      # We need to return an array with <length> packets
      subpackets = length.times.map { parse }
    end

    { version: version, type: type, contents: subpackets }
  end

  private

  # read <count> bits, update the cursor
  def read(count, as_binary: false)
    str = @message[@pos...@pos + count]
    @pos += count
    as_binary ? str : str.to_i(2)
  end

  # read literals
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

module Walker
  def self.walk(node, grabr, processr)
    children = node[:contents]
    return grabr&.call(node) unless children.is_a? Array

    current = [grabr&.call(node)].compact
    further = children.map { |child| walk(child, grabr, processr) }
    processr&.call(current + further)
  end
end


Day16.solve
