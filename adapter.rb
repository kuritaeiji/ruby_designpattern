class Encrypter
  attr_reader(:key)

  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    while !reader.eof?
      clear_char = reader.getc
      writer.putc(clear_char)
      key_index = (key_index + 1) % (key.length)
    end
  ensure
    reader.close
    writer.close
  end
end

class StringIOAdapter
  attr_reader(:string)

  def initialize(string)
    @string = string
  end

  def eof?
    !string[0]
  end

  def getc
    string.slice!(0)
  end

  def close
  end
end

reader = StringIOAdapter.new('aabbbbee')
writer = File.open('messages.encrypted.txt', 'w')
encrypter = Encrypter.new('hibiki1010')
encrypter.encrypt(reader, writer)




class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    puts("text: #{text}, color: #{color}, size: #{size}")
  end
end

class TextObject
  attr_accessor(:text, :size_inches, :color)

  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end

class BritishTextObject
  attr_reader(:text, :size_mm, :color)

  def initialize(text, size_mm, color)
    @text = text
    @size_mm = size_mm
    @color = color
  end
end

class BritishTextObjectAdapter < TextObject
  attr_reader(:bto)

  def initialize(bto)
    @bto = bto
  end

  def size_inches
    bto.size_mm / 25.4
  end
end

bto = BritishTextObject.new('hello', 10.0, :blue)
def bto.size_inches
  size_mm / 25.4
end
renderer = Renderer.new
renderer.render(bto)