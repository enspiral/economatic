module Role
  class CastingException < Exception; end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def cast_actor(actor)
      check_depencies(actor)
      actor.extend(self)
    end

    private

    def check_depencies(actor)
      dependencies.each do |method_name|
        raise CastingException unless actor.respond_to?(method_name)
      end
    end

    def dependencies
      @dependencies ||= []
    end

    def actor_dependency(method_name)
      dependencies << method_name
    end
  end
end