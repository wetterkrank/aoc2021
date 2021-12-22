require_relative 'common'

class Day22 < AdventDay
  def first_part
    grid = input.each_with_object({}) do |instruction, obj|
      ranges, setting = instruction
      next if ranges.any? { |range| range.first < -50 || range.first > 50 }

      puts "Ranges: #{ranges}, setting: #{setting}"
      xr, yr, zr = ranges
      xr.each do |x|
        yr.each do |y|
          zr.each do |z|
            obj[[x, y, z]] = setting
          end
        end
      end
    end
    puts(grid.count { |k, v| v == true })
  end

  def second_part
  end

  private

  def convert_data(data)
    super.map do |line| 
      setting, ranges = line.split 
      axes = ranges.split(',').map { eval(_1[2..]) }
      [axes, setting == 'on']
    end
  end
end

Day22.solve
