require 'spec_helper'
require 'entity'

describe Entity do
  context "when included" do
    class SomeEntity
      include Entity
    end
  end
end
