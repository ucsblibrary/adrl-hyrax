# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work IndexMap`
module Hyrax
  class IndexMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::IndexMap
    self.terms += [:resource_type]
  end
end
