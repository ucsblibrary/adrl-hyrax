# frozen_string_literal: true

class Heck < Hyrax::CatalogSearchBuilder
  include Hyrax::FilterByType
  include Hydra::PolicyAwareAccessControlsEnforcement
  include BlacklightRangeLimit::RangeLimitBuilder
end
