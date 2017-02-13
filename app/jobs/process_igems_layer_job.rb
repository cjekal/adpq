class ProcessIgemsLayerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    endpoint = args[0]
    layer_id = args[1]
    query = args[2]
    category = args[3]

    service = Geoservice::MapService.new(url: endpoint)
    layer = service.query(layer_id, query)
    raise 'could not load data' unless layer['error'].blank?
    layer['features'].each do |feature|
      ProcessIgemsFeatureJob.perform_later(feature, category, endpoint, layer_id)
    end
  end
end
