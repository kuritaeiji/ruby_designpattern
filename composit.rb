require('forwardable')

class Task
  attr_accessor(:name, :parent)

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end

  def total_number_basic_tasks
    1
  end
end

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up')
  end

  def get_time_required
    3.0
  end
end

class CompositTask < Task
  attr_accessor(:sub_tasks)
  extend(Forwardable)
  include(Enumerable)

  def_delegators(:@sub_tasks, :push, :length, :delete)

  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks.push(task)
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.remove(task)
    task.parent = nil
  end

  def total_number_basic_tasks
    @sub_tasks.reduce(0) do |accumulator, sub_task|
      accumulator + sub_task.total_number_basic_tasks
    end
  end
end

class MakeBatterTask < CompositTask
  def initialize
    super('Make Butter')
    add_sub_task(MixTask.new)
    add_sub_task(AddDryIngredientsTask.new)
  end

  def get_time_required
    @sub_tasks.reduce(0) do |accumulator, sub_task|
      accumulator + sub_task.get_time_required
    end
  end
end

make_butter_task = MakeBatterTask.new
puts(make_butter_task.get_time_required)
puts(make_butter_task.total_number_basic_tasks)
