# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work ComponentMap`
module Hyrax
  class ComponentMapForm < Hyrax::Forms::WorkForm
    self.model_class = ::ComponentMap
    self.terms += [:resource_type]
  end
end
