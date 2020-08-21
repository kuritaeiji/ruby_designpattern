require('./interpreter.rb')
require('singleton')
require('fileutils')

def backup(dir, find_expression = All.new)
  Backup.instance.data_sources.push(DataSource.new(dir, find_expression))
end

def to(backup_directory)
  Backup.instance.backup_directory = backup_directory
end

def interval(minutes)
  Backup.instance.interval = minutes
end

class Backup
  attr_accessor(:interval, :backup_directory)
  attr_reader(:data_sources)

  def initialize
    @interval = 60
    @backup_directory = './'
    @data_sources = []
    yield(self)
    PackRat.instance.register_backup(self)
  end

  def backup(dir, find_expression)
    data_sources.push(DataSource.new(dir, find_expression))
  end

  def to(dir)
    self.backup_directory = dir
  end

  def interval(minutes)
    self.interval = minutes
  end

  def backup_files
    this_backup_dir = Time.now
    this_backup_path = File.join(backup_directory, this_backup_dir)
    @data_sources.each do |source|
      source.backup(this_backup_path)
    end
  end

  def run
    loop do
      backup_files
      sleep(interval * 60)
    end
  end
end

class PackRat
  include(Singleton)

  def initialize
    @backups = []
  end

  def register_backup(backup)
    @backups.push(backup)
  end

  def run
    threads = []
    @backups.each do |backup|
      threads.push(Thread.new(backup.run))
    end
    threads.each {|t| t.join }
  end
end

class DataSource
  attr_reader(:directory, :finder_expression)

  def initialize(directory, finder_expression)
    @directory = directory
    @finder_expression = finder_expression
  end

  def backup(backup_directory)
    files = @finder_expression.evaluate(@directory)
    files.each do |file|
      backup_file(file, backup_directory)
    end
  end

  def backup_file(path, backup_directory)
    copy_path = File.join(backup_directory, path)
    FileUtils.mkdir_p(File.dirname(copy_path))
    FileUtils.cp(path, copy_path)
  end
end

eval(File.read('backup.rb'))