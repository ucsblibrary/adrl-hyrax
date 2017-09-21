# frozen_string_literal: true

module Hyrax
  class ETDController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::ETD

    # Use this line if you want to use a custom presenter
    # self.show_presenter = Hyrax::ETDPresenter
  end
end
