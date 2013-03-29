# Finds the actors for a context. The name of this class
# might be a bit creative since I felt the need to explain it.
class TalentScout
  def initialize(context_class)
    @context_class = context_class
  end

  def build_context(params)
    @context_class.new
  end
end