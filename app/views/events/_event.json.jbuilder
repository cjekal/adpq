json.extract! event, :id, :category, :unique_identifier, :zip_code, :additional_info_url, :created_at, :updated_at
json.url event_url(event, format: :json)