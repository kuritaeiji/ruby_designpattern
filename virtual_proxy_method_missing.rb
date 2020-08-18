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

class VirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(name, *args)
    subject.send(name, *args)
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end



class VirtualProxyDefineMethod
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  BankAccount.public_instance_methods(false).each do |name|
    define_method(name) do |*args, &block|
      subject.send(name, *args, &block)
    end
  end

  def subject
    @subjcet || (@subject = @creation_block.call)
  end
end

virtual_proxy = VirtualProxyDefineMethod.new { BankAccount.new(100) }
puts(virtual_proxy.balance)
virtual_proxy.deposit(100)
puts(virtual_proxy.balance)