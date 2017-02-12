module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_resident

    def connect
      self.current_resident = find_verified_resident
    end

    protected
    def find_verified_resident
      if current_res = Resident.find_by(id: cookies.signed[:resident_id])
        return current_res
      else
        reject_unauthorized_connection
      end
    end
  end
end
