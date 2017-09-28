# frozen_string_literal: true

class SearchBuilder < Hyrax::CatalogSearchBuilder
  include BlacklightRangeLimit::RangeLimitBuilder
  include Hydra::AccessControlsEnforcement
  include Hydra::PolicyAwareAccessControlsEnforcement
end
