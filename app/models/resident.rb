class Resident < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email, :zip_code
end
