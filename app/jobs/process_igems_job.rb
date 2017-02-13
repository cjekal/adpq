class ProcessIgemsJob < ApplicationJob
  queue_as :default

  REST_ENDPOINTS = [
    { url: 'https://igems.doi.gov/arcgis/rest/services/igems_haz/MapServer', layers: [10] },
    { url: 'https://igems.doi.gov/arcgis/rest/services/igems_info/MapServer', layers: [0] }
  ].freeze

  def perform(*args)
    REST_ENDPOINTS.each do |endpoint|
      service = Geoservice::MapService.new(url: endpoint[:url])
      endpoint[:layers].each do |layer_id|
        layer = service.layers[layer_id]
        query = {
          f: :pjson,
          outFields: [:objectid, :latitude, :longitude].join(',')
        }
        category = layer['name']

        ProcessIgemsLayerJob.perform_later(endpoint[:url], layer_id, query, category)
      end
    end
  end
end
