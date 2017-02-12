class Resident < ApplicationRecord
  validates_uniqueness_of :email
end
