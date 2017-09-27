# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  mount Blacklight::Engine => "/"
  mount Hyrax::Engine, at: "/"
  mount Hydra::RoleManagement::Engine => "/"
  mount Qa::Engine => "/authorities"

  root "hyrax/homepage#index"
  curation_concerns_basic_routes

  concern :searchable, Blacklight::Routes::Searchable.new
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :welcome, only: "index"

  resource :catalog,
           only: [:index],
           as: "catalog",
           path: "/catalog",
           controller: "catalog" do
    concerns :searchable
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
