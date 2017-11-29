# frozen_string_literal: true

class DefaultSearchBuilder < Hyrax::CatalogSearchBuilder
  include Hyrax::FilterByType
  include Hydra::PolicyAwareAccessControlsEnforcement
  include BlacklightRangeLimit::RangeLimitBuilder
end
