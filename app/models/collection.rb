# frozen_string_literal: true

class Collection < ActiveFedora::Base
  include ::Hyrax::CollectionBehavior
  include Metadata
  include WithAdminPolicy

  self.indexer = CollectionIndexer

  property :issued, predicate: ::RDF::Vocab::DC.issued, class_name: TimeSpan

  property :date_copyrighted,
           predicate: ::RDF::Vocab::DC.dateCopyrighted,
           class_name: TimeSpan

  accepts_nested_attributes_for(
    :creator,
    reject_if: lambda { |attributes| attributes[:id].blank? }
  )

  accepts_nested_attributes_for(
    :collector,
    reject_if: lambda { |attributes| attributes[:id].blank? }
  )

  accepts_nested_attributes_for :issued,
                                reject_if: :time_span_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :date_copyrighted,
                                reject_if: :time_span_blank,
                                allow_destroy: true

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes
end
