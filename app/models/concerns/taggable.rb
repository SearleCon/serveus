module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end

  def tag(taglist)
    names = taglist.split(',').each(&:strip)
    names.each do |name|
     tag = Tag.where(name: name.titleize).first_or_create!
     taggings.where(tag_id: tag.id).first_or_create!
    end
  end

  def tag_names
    tags.collect(&:name)
  end
end