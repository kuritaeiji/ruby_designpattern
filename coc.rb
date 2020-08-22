require('uri')

class Message
  attr_accessor(:from, :to, :body)

  def initialize(from, to, body)
    @from = from
    @to = URI.parse(to)
    @body = body
  end
end

class MessageGateway
  def initialize
    load_adapters
  end

  def send_message(message)
    adapter = adapter_for(message)
    adapter.send_message(message)
  end

  def adapter_for(message)
    protocol = message.to.scheme
    adapter_name = "#{protocol.capitalize}Adapter"
    adapter_class = MessageGateway.const_get(adapter_name)
    adapter_class.new
  end

  def load_adapters
    Dir.glob('./adapters/*_adapter.rb') { |file| require(file) }
  end
end
