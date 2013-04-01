module Scouts
  class EntityFromRepository
    def actor_for_part(part, params)
      repository = part.repository
      if repository
        id_param_key = "#{part.name}_id"
        id_param_value = params[id_param_key]
        repository.find(id_param_value) if id_param_value
      else
        nil
      end
    end
  end
end