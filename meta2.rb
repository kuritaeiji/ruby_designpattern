class CompositBase
  attr_reader(:name)

  def initialize(name)
    @name = name
  end

  def self.member_of(composit_name)
    attr_name = "parent_#{composit_name}"
    raise('method redefition') if instance_methods.include?(attr_name)
    code = %Q{
      attr_accessor(:#{attr_name})
    }
    class_eval(code)
  end

  def self.composit_of(composit_name)
    member_of(composit_name)

    code = %Q{
      def sub_#{composit_name}s
        @sub_#{composit_name}s || []
      end

      def add_sub_#{composit_name}(child)
        return if sub_#{composit_name}s.include?(child)
        sub_#{composit_name}s.push(child)
        child.parent_#{composit_name} = self
      end

      def delete_sub_#{composit_name}(child)
        return unless sub_#{composit_name}s.include?(child)
        sub_#{composit_name}s.delete(child)
        child.parent_#{composit_name} = nil
      end
    }

    class_eval(code)
  end
end

class Tiger < CompositBase
  member_of(:population)
  member_of(:classification)
end

class Jungle < CompositBase
  composit_of(:population)
end

class Species < CompositBase
  composit_of(:classification)
end




class Object
  def self.attr_attribute(name)
    code = %Q{
      def #{name}
        @#{name}
      end

      def #{name}=(value)
        @#{name} = value
      end
    }
    class_eval(code)
  end
end

class BankAccount
  attr_attribute(:balance)

  def initialize(balance)
    @balance = balance
  end
end

bank_account = BankAccount.new(1000)
puts(bank_account.balance)
bank_account.balance = 2000
puts(bank_account.balance)