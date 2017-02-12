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

    it 'should fail if email is blank' do
      resident = residents(:valid)
      resident.email = nil
      resident.valid?
      resident.errors[:email].must_include("can't be blank")
    end

    it 'should fail if zip_code is blank' do
      resident = residents(:valid)
      resident.zip_code = nil
      resident.valid?
      resident.errors[:zip_code].must_include("can't be blank")
    end
  end
end
