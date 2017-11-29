# frozen_string_literal: true

Rails.application.routes.draw do
  mount Blacklight::Engine => "/"
  mount Hyrax::Engine => "/"
  mount Hydra::RoleManagement::Engine => "/"
  mount Qa::Engine => "/authorities"
  mount ::Riiif::Engine => "/image-service", as: "riiif"

  root "hyrax/homepage#index"
  get "hyrax/homepage/about", as: "about"
  get "hyrax/homepage/collection-usage-guidelines",
      as: "collection-usage-guidelines"
  get "hyrax/homepage/using", as: "using"

  curation_concerns_basic_routes

  # new_user_session_path is hardcoded everywhere in Blacklight
  get "sign_in", to: "sessions#new", as: :new_user_session
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

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
