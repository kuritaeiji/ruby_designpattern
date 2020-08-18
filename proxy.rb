require('etc')

class AuthorizationError < StandardError
end

class BankAccount
  attr_accessor(:balance)

  def initialize(starting_balance = 0)
    @balance = starting_balance
  end

  def deposit(amount)
    self.balance += amount
  end

  def widthdraw(amount)
    self.balance -= amount
  end
end

class BankAccountProxy
  def initialize(real_object, owner_name)
    @real_object = real_object
    @owner_name = owner_name
  end

  def deposit(amount)
    check_access
    @real_object.deposit(amount)
  end

  def widthdraw(amount)
    check_access
    @real_object.widthdraw(amount)
  end

  def balance
    check_access
    @real_object.balance
  end

  private
    def check_access
      if !@owner_name == Etc.getlogin
        raise(AuthorizationError.new("Illegal access: #{Etc.getlogin} cannot access account."))
      end
    end
end

account = BankAccount.new(100)
account.deposit(1000)
account.widthdraw(100)
puts(account.balance)

proxy = BankAccountProxy.new(account)
proxy.deposit(1000)
puts(proxy.balance)