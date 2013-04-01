class Part
  attr_accessor :name, :repository

  def initialize(name, options = {})
    @name = name
    @repository = options[:repository]
    @role = options[:role]
  end

  def cast(actor)
    @role ? @role.cast_actor(actor) : actor
  end
end
