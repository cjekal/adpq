require 'test_helper'

class EventTest < ActiveSupport::TestCase
  describe Event do
    it 'should require a category' do
      event = events(:valid_fire)
      event.category = nil
      event.valid?
      event.errors[:category].must_include("can't be blank")
    end

    it 'should require a unique_identifier' do
      event = events(:valid_fire)
      event.unique_identifier = nil
      event.valid?
      event.errors[:unique_identifier].must_include("can't be blank")
    end

    it 'should require a unique unique_identifier for a given endpoint/layer' do
      event = events(:valid_fire)
      other_event = Event.new(endpoint: event.endpoint, layer: event.layer, unique_identifier: event.unique_identifier)
      other_event.valid?
      other_event.errors[:unique_identifier].must_include("has already been taken")
    end
  end
end
