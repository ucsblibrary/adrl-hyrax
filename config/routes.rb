Rails.application.routes.draw do
  devise_for :users

  mount Blacklight::Engine => '/'
  mount Hyrax::Engine, at: '/'
  mount Hydra::RoleManagement::Engine => '/'
  mount Qa::Engine => '/authorities'

  root 'hyrax/homepage#index'
  curation_concerns_basic_routes

  concern :searchable, Blacklight::Routes::Searchable.new
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :welcome, only: 'index'

  resource :catalog,
           only: [:index],
           as: 'catalog',
           path: '/catalog',
           controller: 'catalog' do
    concerns :searchable
  end

  resources :solr_documents,
            only: [:show],
            path: '/catalog',
            controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end
end
