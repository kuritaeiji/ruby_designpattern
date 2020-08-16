require('fileutils')

class Command
  attr_accessor(:description)

  def initialize(description)
    @description = description
  end

  def execute
  end

  def unexecute
  end
end

class CompositCommand < Command
  attr_accessor(:commands)

  def initialize
    @commands = []
  end

  def add_command(command)
    commands.push(command)
  end

  def remove_command(command)
    commands.remove(command)
  end

  def execute
    commands.each {|command| command.execute }
  end

  def unexecute
    commands.reverse_each {|command| command.unexecute }
  end

  def description
    descriptions = commands.reduce('') do |accumulator, command|
      accumulator + command.description
    end
    puts(descriptions)
  end
end

class SlickButton < CompositCommand
  def on_push_button
    execute
  end
end

class FileCreate < Command
  attr_accessor(:path, :content)

  def initialize(path, content)
    super("Create File: #{path}")
    @path = path
    @content = content
  end

  def execute
    File.open(path, 'w') do |f|
      f.write(content)
    end
  end

  def unexecute
    FileUtils.rm(path)
  end
end

class DeleteFile < Command
  attr_accessor(:path, :content)

  def initialize(path)
    super("Delete File: #{path}")
    @path = path
  end

  def execute
    if File.exist?(path)
      File.open(path) do |f|
        self.content = f.read
      end
    end
    FileUtils.rm(path)
  end

  def unexecute
    File.open(path, 'w') do |f|
      f.write(content)
    end
  end
end

class CopyFile < Command
  attr_accessor(:source, :target)

  def initialize(source, target)
    super("Copy File: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.cp(source, target)
  end

  def unexecute
    if File.exists?(target)
      FileUtils.rm(target)
    end
  end
end

slick_button = SlickButton.new
slick_button.add_command(FileCreate.new('file1.txt', 'hello, world'))
slick_button.add_command(CopyFile.new('file1.txt', 'file2.txt'))
slick_button.add_command(DeleteFile.new('file1.txt'))
slick_button.description
slick_button.execute
slick_button.unexecute
