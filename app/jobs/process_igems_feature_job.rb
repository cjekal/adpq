class ProcessIgemsFeatureJob < ApplicationJob
  queue_as :default

  def perform(*args)
    feature = args[0]
    category = args[1]
    endpoint = args[2]
    layer_id = args[3]

    object_id = feature['attributes']['OBJECTID']
    latitude = feature['attributes']['Latitude']
    longitude = feature['attributes']['Longitude']

    Event.find_or_create_by(
      category: category,
      unique_identifier: object_id,
      endpoint: endpoint,
      layer: layer_id,
      latitude: latitude,
      longitude: longitude,
    ) unless no_data?(object_id) || no_data?(latitude) || no_data?(longitude)
  end

  def no_data?(value)
    value.blank? || value =~ /^null$/i
  end
end
