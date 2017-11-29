j# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work MapSet`
class MapSet < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include WithAdminPolicy
  include Metadata

  self.indexer = MapSetIndexer
  self.human_readable_type = "Map Set"

  property :issued, predicate: ::RDF::Vocab::DC.issued, class_name: TimeSpan

  property :date_copyrighted,
           predicate: ::RDF::Vocab::DC.dateCopyrighted,
           class_name: TimeSpan

  validates :title, presence: { message: "Your work must have a title." }
  validates_vocabulary_of :rights_holder
  validates_vocabulary_of :form_of_work

  # Find all the index maps attached to this MapSet
  #
  # Note: These methods should NOT be used for display. They are
  # convenience methods for testing data import only.
  #
  # @return [ActiveFedora::Relation] an array of any matching IndexMap objects
  def index_maps
    IndexMap.where(parent_id_ssim: id)
  end

  # Find all the ComponentMaps attached to this MapSet
  #
  # @return [ActiveFedora::Relation] an array of any matching
  #     ComponentMap objects
  def component_maps
    ComponentMap.where(parent_id_ssim: id)
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes
  accepts_nested_attributes_for :issued,
                                reject_if: :time_span_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :date_copyrighted,
                                reject_if: :time_span_blank,
                                allow_destroy: true
end
