class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("アヒル #{@name}は食事中です。")
  end

  def speak
    puts("アヒル #{@name}が鳴いています")
  end

  def sleep
    puts("アヒル #{@name}は眠っています。")
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("カエル  #{@name}は食事中です")
  end

  def speak
    puts("カエル #{@name}が鳴いています")
  end

  def sleep
    puts("カエル #{@name}は眠っています。")
  end
end

class Algea
  def initialize(name)
    @name = name
  end

  def grow
    puts("藻 #{@name}は日光を浴びて育ちます")
  end
end

class WarterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts("スイレン #{@name}は浮きながら日光を浴びて育ちます")
  end
end

class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, i)
      @animals.push(animal)
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, i)
      @plants.push(plant)
    end
  end

  def simulate_one_day
    @plants.each { |plant| plant.grow }
    @animals.each { |animal| animal.eat }
    @animals.each { |animal| animal.speak }
    @animals.each { |animal| animal.sleep }
  end
end

class DuckWarterLilyPond < Pond
  def new_organism(type, i)
    if type == :animal
      Duck.new("アヒル#{i}")
    else
      WarterLily.new("スイレン#{i}")
    end
  end
end

class FrogAlgeaPond < Pond
  def new_organism(type, i)
    if type == :animal
      Frog.new("カエル#{i}")
    else
      Algea.new("藻#{i}")
    end
  end
end

frog_pond = FrogAlgeaPond.new(10, 10)
frog_pond.simulate_one_day
