class TagsController < ApplicationController


  def index
    @tags = current_user.tags.pluck(:name)
  end
end
