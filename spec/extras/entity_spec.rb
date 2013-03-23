require 'spec_helper'
require 'entity'

describe Entity do
  context "when included" do
    class SomeEntity
      include Entity
    end

    it "includes Virtus" do
      SomeEntity.include?(Virtus).should be_true
    end
  end
end