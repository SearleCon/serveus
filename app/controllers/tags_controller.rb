class TagsController < ApplicationController
   expose(:tags) { current_user.tags.pluck(:name) }
end
