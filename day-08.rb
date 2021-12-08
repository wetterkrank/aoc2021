require_relative 'common'

class Day8 < AdventDay
  def get_unique_segments(all_digits)
    freqs = ('a'..'g').to_a.to_h { |ch| [ch, 0] }
    freqs = all_digits.flatten.each_with_object(freqs) { |seg, arr| arr[seg] += 1 }.invert
    { b: [freqs[6]], e: [freqs[4]], f: [freqs[9]] }
  end

  def get_unique_digits(all_digits)
    lengths = { 1 => 2, 4 => 4, 7 => 3, 8 => 7 }
    lengths.transform_values { |val| all_digits.find { |digit| digit.length == val } }
  end

  def get_digits(all_digits)
    b, e, f = get_unique_segments(all_digits).values_at(:b, :e, :f)
    
    # 1, 4, 7, 8
    digits = get_unique_digits(all_digits)
    digits[2] = digits[8] - b - f
    digits[3] = digits[8] - b - e
    digits[9] = digits[8] - e

    c = digits[1] - f
    digits[5] = digits[8] - c - e
    digits[6] = digits[8] - c
    
    d = digits[4] - b - c - f
    digits[0] = digits[8] - d

    digits # as arrays, order not preserved
  end

  def first_part
    input.reduce(0) do |acc, (_, output)|
      acc + output.count { |segments| [2, 4, 3, 7].include? segments.count }
    end
  end

  def second_part
    input.sum do |(digits, display)|
      digits = get_digits(digits)
      output = display.map { |entry| digits.find { |_, val| val.sort == entry.sort } }
      output.reduce('') { |acc, (num, _)| acc + num.to_s }.to_i
    end
  end

  private

  def convert_data(data)
    super.map { |line| line.split(' | ').map(&:split).map { |part| part.map(&:chars) } }
  end
end

Day8.solve
