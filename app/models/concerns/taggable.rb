module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end


  def tag(names, user)
      tag_list = convert_to_tag_list(names)
      tag_list.each do |item|
        tag = user.tags.where(name: item.titleize).first_or_create!
        taggings.where(tag_id: tag.id).first_or_create!
      end
  end

  def tag_names
    tags.map(&:name)
  end


  def update_tags(names, user)
    tag_list = convert_to_tag_list(names)
    current_tags = tag_names
    if (tag_list <=> current_tags) > 0
      tags_to_add = tag_list - current_tags
      tags_to_add.each do |item|
        tag = user.tags.where(name: item.titleize).first_or_create!
        taggings.where(tag_id: tag.id).first_or_create!
      end
    elsif (tag_list <=> current_tags) < 0
      tags_to_remove = current_tags - tag_list
      taggings.where(tag_id: user.tags.where(name: tags_to_remove)).each(&:destroy)
    end
  end

  private
  def convert_to_tag_list(tag_list)
    tag_list.split(',').collect {|tag| tag.strip.titleize }
  end

end