require "complex"

module AoC1
  def self.bunny_distance(fname)
    calculate_bunny_distance(File.read(fname))
  end

  def self.calculate_bunny_distance(str)
    instructions = parse(str)
    direction = Complex.new(1, 0)
    pos = Complex.new(0, 0)
    destination = instructions.each do |left_or_right, steps|
      direction = direction * turn(left_or_right)
      pos = pos + direction * steps
    end
    Int32.new(pos.real.abs + pos.imag.abs)
  end

  def self.turn(left_or_right)
    case left_or_right
    when 'R'
      Complex.new(0, 1)
    when 'L'
      Complex.new(0, -1)
    else
      raise "unknown direction: #{left_or_right}"
    end
  end

  def self.parse(instructions)
    return [] of Tuple(Char, Int32) if instructions == ""
    instructions.split(", ").map do |pair|
      {pair[0], Int32.new(pair[1..-1])}
    end
  end
end
