class ProcessIgemsLayerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    endpoint = args[0]
    layer_id = args[1]
    query = args[2]

    # https://igems.doi.gov/arcgis/rest/services/igems_haz/MapServer/10/query?f=pjson&geometryType=esriGeometryEnvelope&geometry=-2.0037507842788246E7,-3.024097145838617E7,2.0037507842788246E7,3.0240971458386205E7&outFields=objectid
    layer = Geoservice::MapService.new(:url => "#{endpoint}/#{layer_id}/query?#{query}")
    puts layer
  end
end
