require 'scouts/direct_value'
require 'scouts/entity_from_respository'

# Finds the actors for a context. The name of this class
# might be a bit creative since I felt the need to explain it.
class TalentScout
  def initialize(context_class)
    @context_class = context_class
  end

  def build_context(params)
    @context_class.new(actors_for_params(params))
  end

  private

  def actors_for_params(params)
    actors = {}
    @context_class.parts.each do |part|
      actor = actor_for_part(part, params)
      actors[part.name] = actor if actor
    end
    actors
  end

  def scouts
    [Scouts::DirectValue, Scouts::EntityFromRepository]
  end

  def actor_for_part(part, params)
    scouts.each do |scout|
      actor = scout.actor_for_part(part, params)
      return actor if actor
    end
  end
end