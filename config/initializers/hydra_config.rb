# frozen_string_literal: true

# windows doesn't properly require hydra-head (from the gemfile), so we need to require it explicitly here:
require "hydra/head" unless defined? Hydra

Hydra.configure do |_config|
  def read_ark_from_graph(graph)
    statement = graph.query([nil, ::RDF::Vocab::DC.identifier, nil]).first
    statement.object.to_s if statement.present?
  end

  def uri_from_ark(routes, ark)
    array_of_params = ark.split("/")

    routes.catalog_ark_url(
      *array_of_params,
      host: Rails.application.config.host_name
    )
  end

  def uri_from_model_name(routes, model, id)
    builder = ActionDispatch::Routing::PolymorphicRoutes::HelperMethodBuilder
    builder.polymorphic_method(
      routes,
      model,
      nil,
      :url,
      id: id,
      host: Rails.application.config.host_name
    )
  end

  def uri_from_id(routes, id)
    routes.solr_document_url(id, host: Rails.application.config.host_name)
  end

  # Map internal ids to external paths
  Hydra.config.id_to_resource_uri = lambda do |id, graph|
    result = graph.query([nil,
                          ActiveFedora::RDF::Fcrepo::Model.hasModel,
                          nil,]).first

    model = result.object.to_s.downcase.singularize
    routes = Rails.application.routes.url_helpers

    if routes.respond_to?("#{model}_url".to_sym)
      uri_from_model_name(routes, model, id)
    else
      ark = read_ark_from_graph(graph)
      if ark.blank?
        uri_from_id(routes, id)
      else
        uri_from_ark(routes, ark)
      end
    end
  end
end
