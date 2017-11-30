class ETD < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include WithAdminPolicy
  include Metadata
  include MarcMetadata
  include HumanReadableType
  include EmbargoBehavior

  has_subresource :proquest

  def embargo_indexer_class
    EmbargoIndexer
  end

  self.indexer = ETDIndexer
  self.human_readable_type = "Thesis or dissertation"

  validates :title, presence: { message: "Your work must have a title." }

  property :isbn, predicate: ::RDF::Vocab::Identifiers.isbn do |index|
    index.as :symbol
  end

  property :degree_grantor, predicate: ::RDF::Vocab::MARCRelators.dgg do |index|
    index.as :symbol
  end

  property :keywords, predicate: ::RDF::Vocab::SCHEMA.keywords do |index|
    index.as :stored_searchable
  end

  property :dissertation_degree,
           predicate: ::RDF::Vocab::Bibframe.dissertationDegree

  property :dissertation_institution,
           predicate: ::RDF::Vocab::Bibframe.dissertationInstitution

  property :dissertation_year,
           predicate: ::RDF::Vocab::Bibframe.dissertationYear

  property :issued, predicate: ::RDF::Vocab::DC.issued do |index|
    index.as :displayable
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include NestedAttributes

  # Override Hyrax
  # https://github.com/samvera/hyrax/blob/master/app/models/concerns/hyrax/work_behavior.rb#L39-L45
  def self._to_partial_path
    "catalog/document"
  end
end
