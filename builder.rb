class Computer
  attr_accessor(:display, :motherboard, :drives)

  def initialize(display = :ctr, motherboard = Motherboard.new, drives = [])
    @display = display
    @motherboard = motherboard
    @drives = drives
  end
end

class LaptopComputer < Computer
  def inintialize(motherboard = Motherboard.new, drives = [])
    super(:lcd, motherboard, drives)
  end
end

class DesktopComputer < Computer
  def initialize(display = :ctr, motherboard = Motherboard.new, drives = [])
    super(display, motherboard, drives)
  end
end

class CPU
end

class BasicCPU < CPU
end

class TurboCPU < CPU
end

class Motherboard
  attr_accessor(:cpu, :memory_size)

  def initialize(cpu = BasicCPU.new, memory_size = 1000)
    @cpu = cpu
    @momory_size = memory_size
  end
end

class Drive
  attr_accessor(:type, :size, :writable)

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

class ComputerBuilder
  attr_accessor(:computer)

  def turbo(has_turbo_cpu = true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size(memory_size)
    @computer.motherboard.memory_size = memory_size
  end

  def add_cd(writer = false)
    @computer.drives.push(Drive.new(:cd, 760, writer))
  end

  def add_dvd(writer = false)
    @computer.drives.push(Drive.new(:dvd, 400, writer))
  end

  def add_hard_disk(size)
    @computer.drives.push(Drive.new(:hard_disk, size, true))
  end
end

class LaptopBuilder < ComputerBuilder
  def initialize
    @computer = LaptopComputer.new
  end

  def display=(display)
    raise(ArgumentError.new('display is lcd')) unless display == :lcd
  end

  def computer
    raise('not enough memory') if @computer.motherboard.memory_size < 250
    raise('too many drives') if @computer.drivel.length > 4
    raise('no hard disk') if @computer.drives.detect { |drive| drive.type == :hard_disk }
    @computer
  end

  # add_turbo_and_dvd_and_harddisk

  def method_missing(name, *args, &block)
    words = name.to_s.split('_')
    return super(name, *args, &block) unless words.shift == 'add'
    words.each do |word|
      next if word == 'and'
      turbo if word == 'turbo'
      add_cd if word == 'cd'
      add_dvd if word == 'dvd'
      add_hard_disk(10000) if word == 'harddisk'
    end
  end
end

class DesktopBuilder < ComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    @computer.display = display
  end
end
