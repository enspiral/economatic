require 'playhouse/production'

module Economatic
  class Production < Playhouse::Production
    def initialize #options)
      @plays = [Economatic::EconomaticPlay.new]
      #defaults = {root: root_dir}
      #theatre = Playhouse::Theatre.new(options.merge(defaults))
    end

    attr_reader :plays
  end
end
