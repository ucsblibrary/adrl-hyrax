# frozen_string_literal: true

module HyraxHelper
  include ::BlacklightHelper
  include Hyrax::BlacklightOverride
  include Hyrax::HyraxHelperBehavior

  # @param [SolrDocument, CurationConcerns::FileSetPresenter] doc
  def url_for_document(doc, options = {})
    return unless doc
    # Pull the wrapped solr_doc out of FileSetPresenter
    doc = doc.solr_document if doc.respond_to? :solr_document
    return doc.public_uri if doc.public_uri

    case Array.wrap(doc["has_model_ssim"]).first
    when "Collection"
      collection_path(doc)
    when *Hyrax.config.registered_curation_concern_types
      if doc.ark
        ark_path(doc.ark)
      else
        solr_document_path(search_state.url_for_document(doc, options))
      end
    else
      super
    end
  end

  # we're using our own helper rather than the generated route helper
  # because the default helper escapes
  # slashes. https://github.com/rails/rails/issues/16058
  def ark_path(ark)
    "/lib/#{ark}"
  end

  # Get the URL for tracking search sessions across pages using
  # polymorphic routing
  def session_tracking_path(document, params = {})
    return if document.nil?
    blacklight.track_search_context_path(document, params)
  end
end
