# Generated via
#  `rails generate hyrax:work Text`
module Hyrax
  class TextForm < Hyrax::Forms::WorkForm
    self.model_class = ::Text
    self.terms += [:resource_type]
  end
end
