class SlickButton
  attr_accessor(:command)

  def initialize(command)
    @command = command
  end

  def on_button_push
    command.execute if command
  end
end


class SlickButtonBlock
  attr_accessor(:command)

  def initialize(&block)
    @command = block
  end

  def on_button_push
    command.call if command
  end
end

slick_button_block = SlickButtonBlock.new do
  puts('block was called')
end
slick_button_block.on_button_push