# frozen_string_literal: true

class AudioRecording < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include Metadata
  include MarcMetadata
  include WithAdminPolicy

  self.indexer = AudioRecordingIndexer
  self.human_readable_type = "Audio Recording"

  validates :title, presence: { message: "Your work must have a title." }

  property :issued, predicate: ::RDF::Vocab::DC.issued, class_name: TimeSpan

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes
  accepts_nested_attributes_for :issued,
                                reject_if: :time_span_blank,
                                allow_destroy: true
  # Override Hyrax
  # https://github.com/samvera/hyrax/blob/master/app/models/concerns/hyrax/work_behavior.rb#L39-L45
  def self._to_partial_path
    "catalog/document"
  end
end
