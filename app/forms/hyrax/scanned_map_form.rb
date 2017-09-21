# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work ScannedMap`
module Hyrax
  class ScannedMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::ScannedMap
    self.terms += [:resource_type]
  end
end
