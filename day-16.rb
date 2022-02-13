require_relative 'common'

class Day16 < AdventDay
  def first_part
    message = hex2bin(input)

    puts "Input: #{message}"
    puts "Total bits: #{message.length}"

    packets = parse(message)
    packets.reduce(0) { |acc, elem| acc + elem[:version] }
  end
  
  def second_part
  end
  
  private
  
  def parse(msg, head = 0, packets = nil, bits = nil, stack = [])
    return stack if head + 6 >= msg.length
    
    print "Head: #{head} -> "
    version, type, head = get_prefix(msg, head)
    print "version: #{version}, type: #{type.to_s(2)}\n"

    if type == 4 # literal
      head = skip_literal(msg, head)
    else
      packets, bits, head = get_length(msg, head)
    end

    stack << { version: version, type: type, packets: packets, bits: bits }
    parse(msg, head, packets, bits, stack)
  end

  def skip_literal(str, head)
    head += 5 until str[head] == '0'
    head + 5
  end

  def get_length(str, head)
    mode = str[head]
    head += 1
    if mode == '0'
      packets = nil
      bits = str[head..head + 15].to_i(2)
      head += 15
    else
      bits = nil
      packets = str[head..head + 11].to_i(2)
      head += 11
    end
    [packets, bits, head]
  end

  # converts hex string to bin string with 0-padding
  def hex2bin(str)
    str.hex.to_s(2).rjust(str.length * 4, '0')
  end

  def get_prefix(str, head)
    version = str[head..head + 2].to_i(2)
    type = str[head + 3..head + 5].to_i(2)
    [version, type, head + 6]
  end

  def convert_data(data)
    super.first
  end
end

Day16.solve
