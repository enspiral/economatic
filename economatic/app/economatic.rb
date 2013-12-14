
module Playhouse
  class Application
  end
end

class Economatic < Playhouse::Application
  def initialize(options)
    defaults = {root: root_dir}
    play = Economatic::EconomaticPlay.new
    theatre = Playhouse::Theatre.new(options.merge(defaults))
  end
end

app = Economatic.new(environment: 'development')