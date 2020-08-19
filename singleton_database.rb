require('singleton')

class DatabaseConnectionManager
  include(Singleton)

  def get_connection
  end
end

class PrefWriter
  def write(database_manager, preferences)
    connection = database_manager.get_connection
  end
end

class PrefReader
  def read(database_manager)
    connection = database_manager.get_connection
  end
end

class PreferenceManager
  def initialize
    @reader = PrefReader.new
    @writer = PrefWriter.new
    @preferences = { display_splash: false }
  end

  def save_preferences
    preferences = {}
    @writer.write(DatabaseConnectionManager.instance, @preferences)
  end

  def get_preferences
    @preferences = @reader.read(DatabaseConnectionManager.instance)
  end
end