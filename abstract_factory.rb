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

class Tiger
  def initialize(name)
    @name = name
  end

  def eat
    puts("トラ #{@name}は食事中です")
  end

  def speak
    puts("トラ #{@name}が鳴いています")
  end

  def sleep
    puts("トラ #{@name}は眠っています。")
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

class Tree
  def initialize(name)
    @name = name
  end

  def grow
    puts("樹木 #{@name}は高くそだってます")
  end
end

class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @animals = []
    number_animals.times do |i|
      animal = organism_factory.new_animal(i)
      @animals.push(animal)
    end

    @plants = []
    number_plants.times do |i|
      plant = organism_factory.new_plant(i)
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

class PondOrganismFactory
  def new_animal(i)
    Frog.new("カエル#{i}")
  end

  def new_plant(i)
    Algea.new("藻#{i}")
  end
end

class JungleOrganismFactory
  def new_animal(i)
    Tiger.new("トラ#{i}")
  end

  def new_plant(i)
    Tree.new("樹木#{i}")
  end
end

pond = Habitat.new(3, 3, PondOrganismFactory.new)
pond.simulate_one_day

jungle = Habitat.new(3, 3, JungleOrganismFactory.new)
jungle.simulate_one_day