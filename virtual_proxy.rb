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

class VirtualBankAccount
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def widthdraw(amount)
    subject.widthdraw(amount)
  end

  def balance
    subject.balance
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

account = VirtualBankAccount.new { BankAccount.new(1000) }
account.deposit(1000)
puts(account.balance)