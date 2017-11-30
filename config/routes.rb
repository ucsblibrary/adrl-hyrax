# frozen_string_literal: true

def for_model?(request, model)
  query = [
    ("_query_:\"" +
     ActiveFedora::SolrQueryBuilder
       .construct_query_for_ids([request.params[:id]]) +
     "\""),

    ActiveFedora::SolrQueryBuilder.construct_query_for_rel(
      [[:has_model, model.to_rdf_representation]]
    ),
  ].join(" AND ")
  results = ActiveFedora::SolrService.query query, fl: "has_model_ssim"
  results.present?
end

class CollectionRoutingConcern
  def matches?(request)
    for_model?(request, Collection)
  end
end

Rails.application.routes.draw do
  mount Blacklight::Engine => "/"
  mount Hyrax::Engine => "/"
  mount Hydra::RoleManagement::Engine => "/"
  mount Qa::Engine => "/authorities"
  mount Riiif::Engine => "/image-service", as: "riiif"

  root "hyrax/homepage#index"
  get "hyrax/homepage/about", as: "about"
  get "hyrax/homepage/collection-usage-guidelines", as: "collection-usage-guidelines"
  get "hyrax/homepage/using", as: "using"

  # new_user_session_path is hardcoded everywhere in Blacklight
  get "sign_in", to: "sessions#new", as: :new_user_session
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  get "lib/:prot/:shoulder/:id" => "collections#show",
      constraints: CollectionRoutingConcern.new
  get "lib/:prot/:shoulder/:id" => "catalog#show", as: "catalog_ark"

  concern :searchable, Blacklight::Routes::Searchable.new
  concern :exportable, Blacklight::Routes::Exportable.new
  concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new

  resources :welcome, only: "index"

  resource :catalog,
           only: [:index],
           as: "catalog",
           path: "/catalog",
           controller: "catalog" do
    concerns :searchable
    concerns :range_searchable
  end

  resources :solr_documents,
            only: [:show],
            path: "/catalog",
            controller: "catalog" do
    concerns :exportable
  end

  curation_concerns_basic_routes
  resources :local_authorities, only: :index

  get "authorities/agents/:id",
      to: "local_authorities#show",
      as: "agent"

  get "authorities/people/:id",
      to: "local_authorities#show",
      as: "person"

  get "authorities/groups/:id",
      to: "local_authorities#show",
      as: "group"

  get "authorities/organizations/:id",
      to: "local_authorities#show",
      as: "organization"

  get "authorities/topics/:id",
      to: "local_authorities#show",
      as: "topic"

  resources :bookmarks do
    concerns :exportable

    collection do
      delete "clear"
    end
  end
end
