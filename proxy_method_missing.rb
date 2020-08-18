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
  def initialize(subject)
    @subject = subject
  end

  def method_missing(name, *args)
    puts("Delegating #{name} message to subject.")
    @subject.send(name, *args)
  end
end

class AccountProtectionProxy
  def initialize(subject, owner_name)
    @subject = subject
    @owner_name = owner_name
  end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end

  private
    def check_access
      if Etc.getlogin != @owner_name
        raise(AuthorizationError.new("#{Etc.getlogin} can not access"))
      end
    end
end

account = BankAccount.new(100)
proxy = AccountProtectionProxy.new(account, 'fred')
proxy.deposit(100)