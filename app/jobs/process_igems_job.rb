class ProcessIgemsJob < ApplicationJob
  queue_as :default

  REST_ENDPOINTS = [
    { url: 'https://igems.doi.gov/arcgis/rest/services/igems_haz/MapServer', layers: [0, 1, 3, 5, 10] },
    { url: 'https://igems.doi.gov/arcgis/rest/services/igems_info/MapServer', layers: [0] }
  ].freeze

  def perform(*args)
    REST_ENDPOINTS.each do |endpoint|
      service = Geoservice::MapService.new(:url => endpoint[:url])
      endpoint[:layers].each do |layer_id|
        layer = service.layers[layer_id]
        extent = layer['extent']
        query = {
          f: :pjson,
          geometryType: :esriGeometryEnvelope,
          geometry: "#{extent['xmin']},#{extent['ymin']},#{extent['xmax']},#{extent['ymax']}",
          outFields: :objectid
        }
        ProcessIgemsLayerJob.perform_later(endpoint, layer_id, query.to_query)
      end
    end
  end
end
