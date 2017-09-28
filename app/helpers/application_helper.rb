# frozen_string_literal: true

module ApplicationHelper
  # @param [String] string
  # @return [String]
  def linkify(string)
    string.gsub(URI.regexp(%w[http https]),
                '<a href="\1://\4">\1://\4</a>')
  end

  # Used in {CatalogController} to render notes and restrictions as
  # separate paragraphs
  #
  # @param [Hash] data
  # @return [ActiveSupport::SafeBuffer]
  def not_simple_format(data)
    safe_join(
      data[:value].map do |val|
        val.split('\n\n').map { |para| content_tag(:p, para) }
      end.flatten
    )
  end

  # @param [Hash] data
  # @return [ActiveSupport::SafeBuffer]
  def display_link(data)
    href = data.fetch(:value).first
    link_to(href, href)
  end

  # @return [AdminPolicy]
  def policy_title(document)
    AdminPolicy.find(document.admin_policy_id)
  end
end
