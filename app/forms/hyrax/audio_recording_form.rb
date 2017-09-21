# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work AudioRecording`
module Hyrax
  class AudioRecordingForm < Hyrax::Forms::WorkForm
    self.model_class = ::AudioRecording
    self.terms += [:resource_type]
  end
end
