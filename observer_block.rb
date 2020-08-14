module Subject
  attr_accessor(:observers)

  def initialize
    @observers = []
  end

  def add_observer(observer)
    observers.push(observer)
  end

  def remove_observer(observer)
    observers.remove(observer)
  end

  def notify_observers
    observers.each do |observer|
      observer.call(self)
    end
  end
end

class Employee
  attr_accessor(:name, :title, :salary)

  include(Subject)

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    old_salary = salary
    @salary = new_salary
    notify_observers if old_salary != new_salary
  end
end

fred = Employee.new('fred', 'crane operator', 1000000)
fred.add_observer(-> (employee) { puts("#{employee.name}は#{employee.salary}に昇進")})
fred.salary = 1000000
