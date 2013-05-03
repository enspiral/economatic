require 'scouts/can_construct_object'

module Scouts
  class EntityFromRepository
    include CanConstructObject

    private

    def object_builder(part)
      part.repository
    end

    def param_suffix
      "id"
    end

    def build_method
      :find
    end
  end
end