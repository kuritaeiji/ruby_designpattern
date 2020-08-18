require('forwardable')

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print('\n')
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  extend(Forwardable)
  def_delegators(:@real_writer, :write_line, :pos, :rewind, :close)
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: line")
    @line_number += 1
  end
end

class TimeStanpinWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.now}: #{line}")
  end
end

writer = NumberingWriter.new(TimeStanpinWriter.new(SimpleWriter.new('aaaa.txt')))
writer.write_line('aaaaaa')