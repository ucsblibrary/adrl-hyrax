# frozen_string_literal: true

module Hyrax
  class ETDForm < Hyrax::Forms::WorkForm
    self.model_class = ::ETD
    self.terms += [:resource_type]
  end
end
