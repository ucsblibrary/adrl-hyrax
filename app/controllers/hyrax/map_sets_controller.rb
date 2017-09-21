# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work MapSet`

module Hyrax
  class MapSetsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::MapSet

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::MapSetPresenter
  end
end
