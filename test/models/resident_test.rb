require 'test_helper'

class ResidentTest < ActiveSupport::TestCase
  puts ENV['RAILS_ENV']

  describe Resident do
    it 'should fail if email is not unique' do
      resident = residents(:valid)
      other_resident = Resident.new(email: resident.email, zip_code: '12345')
      other_resident.valid?
      other_resident.errors[:email].must_include('has already been taken')
    end
  end
end
