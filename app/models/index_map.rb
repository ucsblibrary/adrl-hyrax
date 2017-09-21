# frozen_string_literal: true

class IndexMap < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include WithAdminPolicy
  include Metadata
  include WithMapSet

  self.indexer = IndexMapIndexer
  self.human_readable_type = "Index Map"

  after_save :map_set_update_index

  property :issued, predicate: ::RDF::Vocab::DC.issued, class_name: TimeSpan

  property :date_copyrighted,
           predicate: ::RDF::Vocab::DC.dateCopyrighted,
           class_name: TimeSpan

  accepts_nested_attributes_for :issued,
                                reject_if: :time_span_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :date_copyrighted,
                                reject_if: :time_span_blank,
                                allow_destroy: true

  validates :title, presence: { message: "Your work must have a title." }
  validates_vocabulary_of :rights_holder
  validates_vocabulary_of :form_of_work

  # Find all the ComponentMaps attached to this IndexMap
  # @return [ActiveFedora::Relation] an array of any matching
  #     ComponentMap objects
  def component_maps
    ComponentMap.where(index_map_id_ssim: id)
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes
end
