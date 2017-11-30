# frozen_string_literal: true

class Image < ActiveFedora::Base
  include Hyrax::WorkBehavior
  include Metadata
  include WithAdminPolicy
  include EmbargoBehavior

  self.indexer = ImageIndexer
  self.human_readable_type = "Image"

  property :issued, predicate: ::RDF::Vocab::DC.issued, class_name: TimeSpan
  property :date_copyrighted,
           predicate: ::RDF::Vocab::DC.dateCopyrighted,
           class_name: TimeSpan

  validates :title, presence: { message: "Your work must have a title." }
  validates_vocabulary_of :rights_holder
  validates_vocabulary_of :form_of_work

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes
  accepts_nested_attributes_for :issued,
                                reject_if: :time_span_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :date_copyrighted,
                                reject_if: :time_span_blank,
                                allow_destroy: true
  # Override Hyrax
  # https://github.com/samvera/hyrax/blob/master/app/models/concerns/hyrax/work_behavior.rb#L39-L45
  def self._to_partial_path
    "catalog/document"
  end
end
