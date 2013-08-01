module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end

  def tag(names, user)
    tag_list = convert_to_tag_list(names)
    tags.delete_all
    tag_list.each { |item| tags << user.tags.where(name: item).first_or_create! }
  end

  def tag_names
    tags.map(&:name)
  end

  private
  def convert_to_tag_list(tag_list)
    tag_list.split(',').collect {|tag| tag.strip.titleize }
  end

end