# This breaks pry, no good...
include RSpec::Matchers

RSpec::Matchers.define :be_visible do
  match do |element|
    element.visible?
  end
end