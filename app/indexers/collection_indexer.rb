# frozen_string_literal: true

class CollectionIndexer < Hyrax::CollectionIndexer
  self.thumbnail_field = ObjectIndexer.thumbnail_field
  def thumbnail_path
    ActionController::Base.helpers.image_path(
      "fontawesome/black/png/256/archive.png"
    )
  end

  def rdf_service
    Hyrax::DeepIndexingService
  end

  # Override behavior from Hydra::PCDM::CollectionIndexer.
  # When we index the members of this collection in the
  # "member_ids_ssim" field, in addition to the normal hydra
  # collection members, we also want to add any objects that
  # are using the local_collection_id field to indicate
  # membership in this collection.  For more info, see:
  # doc/local_collections.md
  #
  def generate_solr_document
    super.tap do |solr_doc|
      query = ActiveFedora::SolrQueryBuilder.construct_query(
        local_collection_id_ssim: object.id
      )

      rows = ActiveFedora::Base.count.to_s
      results = ActiveFedora::SolrService.query(query, fl: "id", rows: rows)

      solr_doc[Hydra::PCDM::Config.indexing_member_ids_key] +=
        results.map { |doc| doc["id"] }

      solr_doc[Hydra::PCDM::Config.indexing_member_ids_key].uniq!
    end
  end
end
