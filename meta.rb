def new_plant(stem_type, leaf_type)
  plant = Object.new

  if stem_type == :fleshy
    def plant.stem_type
      'fleshy'
    end 
  elsif stem_type == :woody
    def plant.stem_type
      'woody'
    end
  end

  if leaf_type == :broad
    def plant.leaf_type
      'broad'
    end
  elsif leaf_type == :needle
    def plant.leaf_type
      'needle'
    end
  end

  plant
end

plant = new_plant(:fleshy, :broad)
puts(plant.leaf_type)

module Carnivore
  def diet
    'meet'
  end

  def teeth
    'sharp'
  end
end

module Harvivore
  def diet
    'plant'
  end

  def teeth
    'flat'
  end
end

module Nocturnal
  def sleep_time
    'day'
  end

  def awake_time
    'night'
  end
end

module Diurnal
  def sleep_time
    'night'
  end

  def awake_time
    'day'
  end
end

def new_animal(diet, awake)
  animal = Object.new

  if diet == :meat
    animal.extend(Carnivore)
  else
    animal.extend(Harvivore)
  end

  if awake == :day
    animal.extend(Diurnal)
  else
    animal.extend(Nocturnal)
  end
end

animal = new_animal(:meat, :day)
puts(animal.diet)
puts(animal.awake_time)