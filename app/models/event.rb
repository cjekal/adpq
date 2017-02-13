class Event < ApplicationRecord
  validates_presence_of :category, :unique_identifier
  validates_uniqueness_of :unique_identifier, scope: [:endpoint, :layer]
end
