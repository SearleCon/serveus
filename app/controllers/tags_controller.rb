class TagsController < ApplicationController
  def index
    @tags = Tag.pluck(:name)
  end
end
