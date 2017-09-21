# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work AudioRecording`

module Hyrax
  class AudioRecordingsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::AudioRecording

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::AudioRecordingPresenter
  end
end
