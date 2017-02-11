class Notification < ApplicationRecord
  belongs_to :resident
  belongs_to :event
end
