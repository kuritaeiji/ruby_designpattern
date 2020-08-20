require('find')

class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end

class All < Expression
  def evaluate(dir)
    files = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      files.push(p)
    end
    files
  end
end

class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    files = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      files.push(p) if File.fnmatch?(@pattern, name)
    end
    files
  end
end

class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    files = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      files.push(p) if File.size(p) > @size
    end
    files
  end
end

class Writable < Expression
  def evaluate(dir)
    files = []
    Find.find(dir) do |p|
      files.push(p) if File.writable?(p)
    end
    files
  end
end

class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    (@expression1.evaluate(dir) | @expression2.evaluate(dir)).sort
  end
end

class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    @expression1.evaluate(dir) & @expression2.evaluate(dir)
  end
end

# expr_all = All.new
# print(expr_all.evaluate('./'))

# expr_me = FileName.new('*.md')
# print(expr_me.evaluate('./'))

# expr_bigger = Bigger.new(1000)
# print(expr_bigger.evaluate('./'))

# expr_not_writable = Not.new(Writable.new)
# print(expr_not_writable.evaluate('./'))

# expr_not_bigger = Not.new(Bigger.new(1000))
# puts(expr_not_bigger.evaluate('./'))

# big_or_rb_expr = Or.new(Bigger.new(1024), FileName.new('*.rb'))
# puts(big_or_rb_expr.evaluate('./'))

# big_and_rb_expr = And.new(Bigger.new(1024), FileName.new('*.rb'))
# puts(big_and_rb_expr.evaluate('./'))

big_and_rb_expr = Bigger.new(1024) & FileName.new('*.rb')
puts(big_and_rb_expr.evaluate('./'))

class Parser
  def initialize(text)
    @tokens = text.scan(/\(|\)|[\w\.\*]+/)
  end

  def next_token
    @tokens.shift
  end

  def expression
    token = next_token

    if token == nil
      return nil
    elsif token == '('
      result = expression
      raise('Expected)') unless next_token == ')'
      retult
    elsif token == 'all'
      return All.new
    elsif token == "writable"
      return Writable.new
    elsif token == 'bigger'
      return Bigger.new(next_token.to_i)
    elsif token == 'filename'
      return FileName.new(next_token)
    elsif token == 'not'
      return Not.new(expression)
    elsif token == 'and'
      return And.new(expression, expression)
    elsif token == 'or'
      return Or.new(expression, expression)
    else
      raise("unexpected token: #{token}")
    end
  end
end