module Scouts
  class BuildWithComposer
    def actor_for_part(part, params)
      composer = part.composer
      if composer
        attributes_key = "#{part.name}_attributes"
        attributes_value = params[attributes_key]
        composer.compose(attributes_value) if attributes_value
      else
        nil
      end
    end
  end
end