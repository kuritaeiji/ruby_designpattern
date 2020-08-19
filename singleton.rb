class SimpleLogger
  def self.instance
    @instance ||= new
  end

  private_class_method(:new)

  def initialize
    @log = File.open('log.txt', 'w')
  end

  def info(msg)
    @log.puts(msg)
    @log.flush
  end

  def error(msg)
    @log.puts(msg)
    @log.flush
  end

  def warning(msg)
    @log.puts(msg)
    @log.flush
  end
end

logger = SimpleLogger.instance
logger.info('aaaaaaa')

require('singleton')
class SingletonA
  include(Singleton)
end

module ModuleBasedLogger
  @logger = File.open('log.txt', 'w')

  def self.error(msg)
    @logger.puts(msg)
    @logger.flush
  end
end

ModuleBasedLogger.error('bhlhl')