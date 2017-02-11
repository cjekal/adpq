json.extract! resident, :id, :email, :first_name, :last_name, :zip_code, :last_known_zip_code, :created_at, :updated_at
json.url resident_url(resident, format: :json)