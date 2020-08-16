class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

string = 'abc'
i = ArrayIterator.new(string)
while i.has_next?
  puts("item: #{i.next_item}")
end

def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

array = [1, 2, 3]
for_each_element(array) do |element|
  puts(element)
end




require('forwardable')

class Account
  attr_accessor(:parent, :name, :balance)

  include(Comparable)

  def initialize(name, balance)
    @name = name
    @balance = balance
    @parent = nil
  end

  def <=>(other)
    @balance <=> other.balance
  end
end

class Portfolios
  attr_accessor(:accounts)

  include(Enumerable)
  extend(Forwardable)

  def initialize
    @accounts = []
  end

  def_delegators(:@accounts, :any?, :all?)

  def add_account(account)
    @accounts.push(account)
    account.parent = self
  end
end

portfolio = Portfolio.new
portfolio.add_account(Account.new('eiji', 1000))
portfolio.add_account(Account.new('kurita', 2000))

puts(portfolio.all? {|account| account.balance > 1})
puts(portfolio.accounts[0] > portfolio.accounts[1])