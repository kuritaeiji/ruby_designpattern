require('observer')

class Employee
  attr_reader(:name)
  attr_accessor(:title, :salary)

  include(Observable)

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def sarlary=(salary)
    @salary = salary
    changed
    notify_observers(self)
  end
end

class Payroll
  def update(employee)
    puts("#{employee.name}の給料は#{employee.salary}")
  end
end

class TaxMan
  def update(employee)
    puts("#{employee.name}に税金の請求書を送ります。")
  end
end

fred = Employee.new('Fred', 'Crane Operator', 1000000)
taxman = TaxMan.new
payroll = Payroll.new
fred.add_observer(payroll)
fred.add_observer(taxman)
fred.sarlary = 1500000