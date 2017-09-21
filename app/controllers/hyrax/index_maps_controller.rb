# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work IndexMap`

module Hyrax
  class IndexMapsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::IndexMap

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::IndexMapPresenter
  end
end
